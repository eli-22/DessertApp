//
//  ContentView.swift
//  DessertApp
//
//  Created by Elise on 4/15/23.
//

import SwiftUI

struct DessertListView: View {
    
    @StateObject var dessertListVM = DessertListViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(dessertListVM.sortedDesserts, id: \.self) { dessert in
                        NavigationLink(
                            destination: DessertDetailView(
                                dessertDetailVM: DessertDetailViewModel(selectedDessert: dessert))) {
                                    DessertCell(dessert: dessert)
                                        .onTapGesture {
                                            dessertListVM.selectedDessert = dessert
                                        }
                                }
                    }
                }
                .navigationTitle("Desserts 🧁 🍮 🍨")
            }
            .task {
                dessertListVM.getDessertList()
            }
            if dessertListVM.isLoading {
                LoadingSpinner()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DessertListView()
    }
}
