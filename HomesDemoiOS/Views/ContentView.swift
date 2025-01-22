//
//  ContentView.swift
//  HomesDemoiOS
//
//  Created by Parth Anand on 16/01/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            TabView {
                SearchHomesView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                FavouriteHomesView()
                    .tabItem {
                        Label("Favourites", systemImage: "heart")
                    }
                
                Text("Home Screen")
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                
                Text("Profile Screen")
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
            }
    }
}

//#Preview {
//    ContentView()
//}
