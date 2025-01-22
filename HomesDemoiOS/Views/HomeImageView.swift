//
//  HomeImageView.swift
//  HomesDemoiOS
//
//  Created by Parth Anand on 16/01/25.
//

import SwiftUI

struct HomeImageView: View {
    
    @StateObject var homeImageViewModel: HomeImageViewModel
    
    init(home: Home) {
        _homeImageViewModel = StateObject(wrappedValue: HomeImageViewModel(home: home))
    }
    
    var body: some View {
        
        if let image = homeImageViewModel.homeImage {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                
        }
    }
}

#Preview {
    HomeImageView(home: Home(id: 000, price: 000, area: 000, numBedrooms: 000, numBathrooms: 000, city: "test city", state: "test state", latitude: 0.0, longitude: 0.0, imageURL1: "https://firebasestorage.googleapis.com/v0/b/aerolarri-a873e.appspot.com/o/Images%2Fhome1.jpg?alt=media&token=b8a61860-3cf4-4eb6-bebb-47b50c69f654", imageURL2: ""))
}
