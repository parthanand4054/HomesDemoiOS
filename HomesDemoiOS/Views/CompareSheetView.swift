//
//  CompareSheetView.swift
//  HomesDemoiOS
//
//  Created by Parth Anand on 17/01/25.

import SwiftUI
import SwiftUI

struct CompareSheetView: View {
    
    let selectedHomes: [Home]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: 1) {
                    
                    headerImages
                    
                    dataRows
                }
                .padding(8)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("Compare Homes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
            
            Spacer()
        }
    }
    
    private func makeRow(label: String, values: [String]) -> some View {
        HStack(spacing: 1) {
            Text(label)
                .frame(width: 120, height: 50, alignment: .leading)
                .padding(.leading, 8)
                .background(.white)
            
            ForEach(values, id: \.self) { value in
                Text(value)
                    .frame(width: 120, height: 50, alignment: .leading)
                    .padding(.leading, 8)
                    .background(.white)
            }
        }
    }
}



#Preview {
    CompareSheetView(selectedHomes: [])
}


// MARK: View Extension

extension CompareSheetView {
    
    var headerImages: some View {
        HStack(spacing: 1) {
            Rectangle()
                .fill(.clear)
                .frame(width: 120, height: 100)
            
            // Home Images
            ForEach(selectedHomes) { home in
                VStack {
                    AsyncImage(url: URL(string: home.imageURL1)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 70)
                                .clipped()
                        } else {
                            Color.gray
                                .frame(width: 100, height: 70)
                        }
                    }
                }
                .frame(width: 120, height: 100)
                .background(.white)
                .cornerRadius(6)
            }
        }
    }
    
    var dataRows: some View {
        
        VStack(spacing: 1) {
            makeRow(label: "Status", values: selectedHomes.map { _ in "For Sale" })
            
            makeRow(label: "List Price",
                    values: selectedHomes.map { "$\($0.price.formatted())" })
            
            makeRow(label: "Monthly Cost",
                    values: selectedHomes.map { "$\(Int(Double($0.price) * 0.005))" })
            
            makeRow(label: "Price / SqFt",
                    values: selectedHomes.map { "$\(Int(Double($0.price) / Double($0.area)))" })
            
            makeRow(label: "Bedrooms",
                    values: selectedHomes.map { "\($0.numBedrooms)" })
            
            makeRow(label: "Bathrooms",
                    values: selectedHomes.map { "\($0.numBathrooms)" })
            
            makeRow(label: "Square feet",
                    values: selectedHomes.map { "\($0.area)" })
            
        }
    }
}
