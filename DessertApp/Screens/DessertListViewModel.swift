//
//  DessertListViewModel.swift
//  DessertApp
//
//  Created by Elise on 4/15/23.
//

import SwiftUI

@MainActor
final class DessertListViewModel: ObservableObject {
    
    // Array will be populated with dessert objects from API.
    @Published var sortedDesserts: [Dessert] = []
    
    // Show spinner while data loads.
    @Published var isLoading = false
    
    // Will have value once user clicks on a dessert cell.
    @Published var selectedDessert: Dessert?
    
    // Alert user in case of server error.
    @Published var alertItem: AlertItem?
    
    func getDessertList() {
        isLoading = true
        
        Task {
            do {
                let desserts = try await NetworkManager.shared.getDessertList(url: NetworkManager.shared.dessertListURL)
                sortedDesserts = desserts.sorted { $0.strMeal < $1.strMeal }
                isLoading = false
            } catch {
                if let error = error as? DessertAppError {
                    switch error {
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                } else {
                    alertItem = AlertContext.unableToComplete
                }
                isLoading = false
            }
        }
    }
}
