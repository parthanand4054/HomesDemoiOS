//
//  SearchHomesView.swift
//  HomesDemoiOS
//
//  Created by Parth Anand on 16/01/25.
//

import SwiftUI
import MapKit

struct SearchHomesView: View {
    @EnvironmentObject var searchHomesViewModel: SearchHomesViewModel
    @State var searchText = ""
    @State var showListView: Bool = false

    var body: some View {
        
        VStack {
            header
            
            if !showListView {
                mapLayer
            } else {
                listLayer
            }
            
            
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    NavigationStack {
        SearchHomesView()
    }
    .environmentObject(SearchHomesViewModel())
}





// MARK: View Extension
extension SearchHomesView {
    var header: some View {
        VStack(spacing: 8) {
            HStack {
                HStack {
                    Image(systemName: "paperplane")
                        .foregroundColor(.gray)
                    
                    TextField("Map Area", text: $searchText)
                        .foregroundColor(.black)
                        .padding(.horizontal, 10)
                        .frame(height: 40)
                }
                .padding(.horizontal)
                .frame(height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                )

                
                Spacer()
                
                Button(action: {
                    print("Filters tapped")
                }) {
                    HStack {
                        Image(systemName: "slider.horizontal.3")
                        Text("Filters")
                    }
                    .foregroundColor(.black)
                }
            }
            .padding(.top, 45)
            
            HStack {
                Text("\(searchHomesViewModel.homes.count) homes for sale")
                    .font(.headline)
                    .fontWeight(.light)
                
                Spacer()
                
                Button(action: {
                    print("Save tapped")
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.down")
                        Text("Save")
                    }
                    .padding(.horizontal,12)
                }
                
                Button(action: {
                    showListView.toggle()
                }) {
                    HStack {
                        Image(systemName: showListView ? "map" : "list.bullet")
                        Text(showListView ? "Map": "List")
                    }
                }
            }
            .padding(.top, 13)
            .foregroundColor(.black)
        }
        .padding()
        .background(
            Color.white
                .shadow(radius: 3)
        )
    }

    var mapLayer: some View {
        Map(coordinateRegion: $searchHomesViewModel.mapRegion,
            annotationItems: searchHomesViewModel.homes) { home in
            MapAnnotation(coordinate: home.coordinates) {
                VStack {
                    Image(systemName: "house.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                        .background(
                            Circle()
                                .fill(Color.white)
                                .frame(width: 40, height: 40)
                        )
                        .shadow(radius: 3)
                }
            }
        }
    }
    
    var listLayer: some View {
        List {
            ForEach(searchHomesViewModel.homes) { home in
                HomeListingView(home: home)
            }
        }
        .listStyle(.plain)
    }
}
