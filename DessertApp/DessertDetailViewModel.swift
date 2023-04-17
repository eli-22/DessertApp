//
//  DessertDetailViewModel.swift
//  DessertApp
//
//  Created by Elise on 4/16/23.
//

import Foundation

@MainActor
class DessertDetailViewModel: ObservableObject {
    
    // Dessert object selected by user on previous screen (DessertListView).
    var selectedDessert: Dessert
    
    // Response from API will be "meals" dessert array (which contains only one dessert).
    var dessertResponse: [DessertDetail] = []
    
    // This will the the first (and only) object in the "meals" array.
    var dessertDetail: DessertDetail?
    
    var ingredientArray: [String] = []
    var measurementArray: [String] = []
    var ingredientMeasurements: [String : String] = [:]
    
    // Show spinner while data loads.
    @Published var isLoading = false
    
    @Published var alertItem: AlertItem?
    
    init(selectedDessert: Dessert) {
        self.selectedDessert = selectedDessert
    }
    
    func getIngredients(dessertDetail: DessertDetail) {
        var allIngredientValues: [String?] = []
        
        allIngredientValues.append(dessertDetail.strIngredient1)
        allIngredientValues.append(dessertDetail.strIngredient2)
        allIngredientValues.append(dessertDetail.strIngredient3)
        allIngredientValues.append(dessertDetail.strIngredient4)
        allIngredientValues.append(dessertDetail.strIngredient5)
        allIngredientValues.append(dessertDetail.strIngredient6)
        allIngredientValues.append(dessertDetail.strIngredient7)
        allIngredientValues.append(dessertDetail.strIngredient8)
        allIngredientValues.append(dessertDetail.strIngredient9)
        allIngredientValues.append(dessertDetail.strIngredient10)
        allIngredientValues.append(dessertDetail.strIngredient11)
        allIngredientValues.append(dessertDetail.strIngredient12)
        allIngredientValues.append(dessertDetail.strIngredient13)
        allIngredientValues.append(dessertDetail.strIngredient14)
        allIngredientValues.append(dessertDetail.strIngredient15)
        allIngredientValues.append(dessertDetail.strIngredient16)
        allIngredientValues.append(dessertDetail.strIngredient17)
        allIngredientValues.append(dessertDetail.strIngredient18)
        allIngredientValues.append(dessertDetail.strIngredient19)
        allIngredientValues.append(dessertDetail.strIngredient20)
        
        var ingredients = allIngredientValues.compactMap { element in
            return element
        }
        
        ingredientArray = ingredients.map { $0.capitalized }
        print(ingredientArray)
    }
    
    func getMeasurements(dessertDetail: DessertDetail) {
        var allMeasurementValues: [String?] = []
        
        allMeasurementValues.append(dessertDetail.strMeasure1)
        allMeasurementValues.append(dessertDetail.strMeasure2)
        allMeasurementValues.append(dessertDetail.strMeasure3)
        allMeasurementValues.append(dessertDetail.strMeasure4)
        allMeasurementValues.append(dessertDetail.strMeasure5)
        allMeasurementValues.append(dessertDetail.strMeasure6)
        allMeasurementValues.append(dessertDetail.strMeasure7)
        allMeasurementValues.append(dessertDetail.strMeasure8)
        allMeasurementValues.append(dessertDetail.strMeasure9)
        allMeasurementValues.append(dessertDetail.strMeasure10)
        allMeasurementValues.append(dessertDetail.strMeasure11)
        allMeasurementValues.append(dessertDetail.strMeasure12)
        allMeasurementValues.append(dessertDetail.strMeasure13)
        allMeasurementValues.append(dessertDetail.strMeasure14)
        allMeasurementValues.append(dessertDetail.strMeasure15)
        allMeasurementValues.append(dessertDetail.strMeasure16)
        allMeasurementValues.append(dessertDetail.strMeasure17)
        allMeasurementValues.append(dessertDetail.strMeasure18)
        allMeasurementValues.append(dessertDetail.strMeasure19)
        allMeasurementValues.append(dessertDetail.strMeasure20)
        
        measurementArray = allMeasurementValues.compactMap { element in
            return element
        }
    }
    
    func createIngredientList() {
        for i in 0..<ingredientArray.count {
            if !ingredientArray[i].isEmpty {
                ingredientMeasurements.updateValue(measurementArray[i], forKey: ingredientArray[i])
            }
        }
        print(ingredientMeasurements)
    }
    
    func getDessertDetails() {
        isLoading = true
        
        Task {
            do {
                dessertResponse = try await NetworkManager.shared.getDessertDetail(mealID: selectedDessert.idMeal)
                dessertDetail = dessertResponse.first
                if let dessertDetail = dessertResponse.first {
                    getIngredients(dessertDetail: dessertDetail)
                    getMeasurements(dessertDetail: dessertDetail)
                    createIngredientList()
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
}
