//
//  HomesDemoiOSApp.swift
//  HomesDemoiOS
//
//  Created by Parth Anand on 16/01/25.
//

import SwiftUI

@main
struct HomesDemoiOSApp: App {
    
    @StateObject var searchHomesViewModel = SearchHomesViewModel()
    @StateObject var favouritedManager = FavoritesManager()
    
    var body: some Scene {
        WindowGroup {
                ContentView()
            
        }
        .environmentObject(searchHomesViewModel)
        .environmentObject(favouritedManager)
    }
}
