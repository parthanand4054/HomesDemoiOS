//
//  SearchHomesViewModel.swift
//  HomesDemoiOS
//
//  Created by Parth Anand on 16/01/25.
//

import Foundation
import MapKit
import SwiftUI
import Combine

class SearchHomesViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var homes: [Home] = []
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init() {
        getData()
    }
    
    func updateMapRegion(home: Home) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: home.coordinates,
                span: mapSpan)
        }
    }
    
    func getData() {
        
        guard let url = URL(string: "https://gist.githubusercontent.com/parthanand4054/041c75154566fac7cbe0eb8d218cd5a8/raw/1309f0cb22f4203e98826d34933da92c90d8a4ce/homes.json") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(URLError.badServerResponse)
                }
                return data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: Welcome.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    return
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] receivedValue in
                
                guard let self = self else {return}
                
                self.homes = receivedValue.homes
                
                if let firstHome = self.homes.first {
                    self.updateMapRegion(home: firstHome)
                }
                
            }
            .store(in: &cancellables)

    }
    
}
