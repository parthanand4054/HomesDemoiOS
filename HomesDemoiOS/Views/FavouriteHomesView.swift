//
//  FavouriteHomesView.swift
//  HomesDemoiOS
//
//  Created by Parth Anand on 16/01/25.
//

import SwiftUI

struct FavouriteHomesView: View {
    @EnvironmentObject var viewModel: SearchHomesViewModel
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    @State private var selectedHomeIDs: Set<Int> = []
    @State private var showCompareSheet: Bool = false
    
    var body: some View {
            VStack {
                if selectedHomeIDs.count >= 2 {
                    Button("Compare (\(selectedHomeIDs.count))") {
                        showCompareSheet = true
                    }
                }
                
                List {
                    ForEach(viewModel.homes.filter { favoritesManager.isFavorite($0) }) { home in
                        HomeListingView(
                            home: home,
                            showCheckmark: true,
                            isSelectedForCompare: selectedHomeIDs.contains(home.id)
                        ) {
                            toggleHomeSelection(home)
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Favourites")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Compare (\(selectedHomeIDs.count))") {
//                        showCompareSheet = true
//                    }
//                    .opacity(selectedHomeIDs.count >= 2 ? 1 : 0)
//                    .disabled(selectedHomeIDs.count < 2)
//                }
//            }
            .sheet(isPresented: $showCompareSheet, onDismiss: {
                selectedHomeIDs.removeAll()
            }) {
                let selectedHomes = viewModel.homes.filter { selectedHomeIDs.contains($0.id) }
                CompareSheetView(selectedHomes: selectedHomes)
            }
    }
    
    private func toggleHomeSelection(_ home: Home) {
        if selectedHomeIDs.contains(home.id) {
            selectedHomeIDs.remove(home.id)
        } else {
            selectedHomeIDs.insert(home.id)
        }
    }
}

#Preview {
    NavigationStack {
        FavouriteHomesView()
            .environmentObject(SearchHomesViewModel())
            .environmentObject(FavoritesManager())
    }
}
