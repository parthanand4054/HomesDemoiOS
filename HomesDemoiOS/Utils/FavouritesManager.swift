//
//  FavouritesManager.swift
//  HomesDemoiOS
//
//  Created by Parth Anand on 16/01/25.
//

import SwiftUI

class FavoritesManager: ObservableObject {
    
    @Published private(set) var favorites: [Int] = []
    
    private let favoritesKey = "favoriteHomeIDs"
    
    init() {
        loadFavorites()
    }
    
    private func loadFavorites() {
        let defaults = UserDefaults.standard
        if let savedArray = defaults.array(forKey: favoritesKey) as? [Int] {
            favorites = savedArray
        } else {
            favorites = []
        }
    }
    
    private func saveFavorites() {
        let defaults = UserDefaults.standard
        defaults.set(favorites, forKey: favoritesKey)
    }
    
    func isFavorite(_ home: Home) -> Bool {
        favorites.contains(home.id)
    }
    
    func toggleFavorite(_ home: Home) {
        if let index = favorites.firstIndex(of: home.id) {
            favorites.remove(at: index)
        } else {
            favorites.append(home.id)
        }
        
        saveFavorites()
        
        objectWillChange.send()
    }
}
