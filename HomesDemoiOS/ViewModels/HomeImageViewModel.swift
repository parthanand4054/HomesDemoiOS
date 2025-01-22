//
//  HomeImageViewModel.swift
//  HomesDemoiOS
//
//  Created by Parth Anand on 16/01/25.
//

import Foundation
import SwiftUI
import Combine

class HomeImageViewModel: ObservableObject {
    
    let home: Home
    @Published var homeImage: UIImage? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init(home: Home) {
        self.home = home
        getImage()
    }
    
    private func getImage() {
        
        guard let url = URL(string: home.imageURL1) else {return}
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> UIImage? in
                
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300
                else {
                    throw URLError(URLError.badServerResponse)
                }
                return UIImage(data: data)
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] receivedImage in
                guard let self = self else {return}
                self.homeImage = receivedImage
            }
            .store(in: &cancellables)
    }
    
}
