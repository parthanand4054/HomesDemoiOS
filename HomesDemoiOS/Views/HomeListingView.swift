//
//  HomeListingView.swift
//  HomesDemoiOS
//
//  Created by Parth Anand on 16/01/25.
//
import SwiftUI

struct HomeListingView: View {
    var home: Home
    
    var showCheckmark: Bool = false
    var isSelectedForCompare: Bool = false
    var onCheckmarkTap: (() -> Void)? = nil
    
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 10) {
                HomeImageView(home: home)
                    .scaledToFit()
                    .cornerRadius(5)
                
                priceAndFavourite
                
                bedsBathArea
                
                cityAndState
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.white)
                    .shadow(radius: 3)
            )
            
            if showCheckmark {
                Button(action: {
                    onCheckmarkTap?()
                }) {
                    Image(systemName: isSelectedForCompare ? "checkmark.square.fill" : "square")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(isSelectedForCompare ? .white : .white)
                        .padding()
                }
            }
        }
    }
}


#Preview {
    HomeListingView(home: Home(id: 0, price: 1_325_000, area: 1_717, numBedrooms: 4, numBathrooms: 2, city: "San Andreas", state: "GTA", latitude: 0.0, longitude: 0.0, imageURL1: "https://firebasestorage.googleapis.com/v0/b/aerolarri-a873e.appspot.com/o/Images%2Fhome1.jpg?alt=media&token=b8a61860-3cf4-4eb6-bebb-47b50c69f654", imageURL2: ""))
        .environmentObject(FavoritesManager())
}


extension HomeListingView {
    var priceAndFavourite: some View {
        HStack {
            Text("$\(home.price)")
                .font(.title3)
                .fontWeight(.medium)
            
            Spacer()
            
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 25, height: 22)
                .foregroundColor(
                    favoritesManager.isFavorite(home) ? .red : .gray.opacity(0.4)
                )
                .onTapGesture {
                    favoritesManager.toggleFavorite(home)
                }
        }
        .padding(.horizontal)
    }
    
    var bedsBathArea: some View {
        HStack {
            Text("\(home.numBedrooms) Beds • \(home.numBathrooms) Baths • \(home.area) Sq FT")
            Spacer()
        }
        .padding(.horizontal)
    }
    
    var cityAndState: some View {
        HStack {
            Text("\(home.city), \(home.state)")
            Spacer()
        }
        .padding(.horizontal)
    }
}
