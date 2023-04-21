//
//  DessertDetailViewModel.swift
//  DessertApp
//
//  Created by Elise on 4/16/23.
//

import SwiftUI

@MainActor
class DessertDetailViewModel: ObservableObject {
    
    // Dessert object selected by user on previous screen (DessertListView).
    var selectedDessert: Dessert
    
    // Response from API will be "meals" dessert array (which contains only one dessert).
    var dessertResponse: [DessertDetail] = []
    
    // This will the the first (and only) object in the "meals" array.
    var dessertDetail: DessertDetail?
    
    // Array of tuples (rather than a dictionary) to maintain the order of ingredients when displayed.
    var ingredientMeasurements: [(String, String)] = []
    
    // Show spinner while data loads.
    @Published var isLoading = false
    
    // Alert user in case of server error.
    @Published var alertItem: AlertItem?
    
    init(selectedDessert: Dessert) {
        self.selectedDessert = selectedDessert
    }
    
    func getDessertDetails() {
        isLoading = true
        
        Task {
            do {
                dessertResponse = try await NetworkManager.shared.getDessertDetail(mealID: selectedDessert.idMeal)
                dessertDetail = dessertResponse.first
                if let dessertDetail = dessertResponse.first {
                    let allIngredientValues = getIngredients(dessertDetail: dessertDetail)
                    let nonNilNonEmptyIngredients = removeNilOrEmptyIngredients(allIngredients: allIngredientValues)
                    let formattedOutput = formatOutput(ingredientArray: nonNilNonEmptyIngredients)
                    ingredientMeasurements = formattedOutput
                    print(ingredientMeasurements)
                }
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
    
    func getIngredients(dessertDetail: DessertDetail) -> [(String?, String?)] {
        
        var allIngredientValues: [(String?, String?)] = []
        
        allIngredientValues.append(contentsOf: [
            (dessertDetail.strIngredient1, dessertDetail.strMeasure1),
            (dessertDetail.strIngredient2, dessertDetail.strMeasure2),
            (dessertDetail.strIngredient3, dessertDetail.strMeasure3),
            (dessertDetail.strIngredient4, dessertDetail.strMeasure4),
            (dessertDetail.strIngredient5, dessertDetail.strMeasure5),
            (dessertDetail.strIngredient6, dessertDetail.strMeasure6),
            (dessertDetail.strIngredient7, dessertDetail.strMeasure7),
            (dessertDetail.strIngredient8, dessertDetail.strMeasure8),
            (dessertDetail.strIngredient9, dessertDetail.strMeasure9),
            (dessertDetail.strIngredient10, dessertDetail.strMeasure10),
            (dessertDetail.strIngredient11, dessertDetail.strMeasure11),
            (dessertDetail.strIngredient12, dessertDetail.strMeasure12),
            (dessertDetail.strIngredient13, dessertDetail.strMeasure13),
            (dessertDetail.strIngredient14, dessertDetail.strMeasure14),
            (dessertDetail.strIngredient15, dessertDetail.strMeasure15),
            (dessertDetail.strIngredient16, dessertDetail.strMeasure16),
            (dessertDetail.strIngredient17, dessertDetail.strMeasure17),
            (dessertDetail.strIngredient18, dessertDetail.strMeasure18),
            (dessertDetail.strIngredient19, dessertDetail.strMeasure19),
            (dessertDetail.strIngredient20, dessertDetail.strMeasure20)])
        
        return allIngredientValues
    }
    
    // Delete tuples with nil or empty ingredient values from ingredient array.
    func removeNilOrEmptyIngredients(allIngredients: [(String?, String?)]) -> [(String?, String?)] {
        let filteredArray = allIngredients.filter { $0.0 != nil && $0.0 != "" }
        return filteredArray
    }
    
    // Capitalize ingredients, display missing measurement message if needed.
    // I did not filter measurement values here in case there is a listed ingredient without a corresponding measurement. I think it's better to leave the ingredient on the list with no measurement value than to delete it entirely, so I changed nil or empty measurements to a "No measurement specified" message.
    func formatOutput(ingredientArray: [(String?, String?)]) -> [(String, String)] {
        
        var formattedOutput: [(String, String)] = []
        
        // Display messsage if ingredient has no corresponding measurement.
        for i in 0..<ingredientArray.count {
            let tuple: (String, String)
            tuple.0 = ingredientArray[i].0 ?? "" // Nil values have already been filtered out.
            if ingredientArray[i].1 == "" {
                tuple.1 = "No measurement specified."
            } else {
                tuple.1 = ingredientArray[i].1 ?? "No measurement specified."
            }
            formattedOutput.append(tuple)
        }
        
        // Capitalize ingredients.
        formattedOutput = formattedOutput.map { ($0.0.capitalized, $0.1) }
        return formattedOutput
    }
}
