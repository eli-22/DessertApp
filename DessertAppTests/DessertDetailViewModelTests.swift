//
//  DessertDetailViewModelTests.swift
//  DessertAppTests
//
//  Created by Elise on 4/20/23.
//

import XCTest
@testable import DessertApp

@MainActor
final class DessertDetailViewModelTests: XCTestCase {
    
    let dessertDetailVM = DessertDetailViewModel(selectedDessert: MockData.mockDessert)
    
    func test_DessertDetailViewModel_getDessertDetails_shouldPopulateDetailArray() async throws {
        Task {
            dessertDetailVM.getDessertDetails()
            XCTAssertFalse(dessertDetailVM.dessertResponse.isEmpty, "Call should populate array with one Dessert object.")
        }
    }
    
    func test_DessertDetailViewModel_getDessertDetails_isLoading() async throws {
        Task {
            dessertDetailVM.getDessertDetails()
            XCTAssertTrue(dessertDetailVM.isLoading, "isLoading should be true while network call completes.")
        }
        XCTAssertFalse(dessertDetailVM.isLoading, "isLoading should be false after network call completes.")
    }
    
    func test_DessertDetailViewModel_getIngredients_shouldReturnAllIngredients() {
        
        let dessert = MockData.mockDessertDetail
        let allIngredientValues =  dessertDetailVM.getIngredients(dessertDetail: dessert)
        let expectedValues = [
            ("test ingredient 1", "1 cup"),
            ("TEST ingredient 2", "2 teaspoons"),
            ("ingredient without measurement", nil),
            (nil, nil),
            (nil, nil)
        ]
    
        XCTAssertTrue(
            allIngredientValues[0] == expectedValues[0] &&
            allIngredientValues[1] == expectedValues[1] &&
            allIngredientValues[2] == expectedValues[2] &&
            allIngredientValues[3] == expectedValues[3] &&
            allIngredientValues[4] == expectedValues[4]
        )
    }
    
    func test_DessertDetailViewModel_removeNilOrEmptyIngredients_shouldFilterNilAndEmptyIngredientValues() {
        
        let dessert = MockData.mockDessertDetail
        let allIngredientValues =  dessertDetailVM.getIngredients(dessertDetail: dessert)
        let filteredIngredients = dessertDetailVM.removeNilOrEmptyIngredients(allIngredients: allIngredientValues)
        let expectedValues = [
            ("test ingredient 1", "1 cup"),
            ("TEST ingredient 2", "2 teaspoons"),
            ("ingredient without measurement", nil)
        ]
        
        XCTAssertTrue(
            filteredIngredients[0] == expectedValues[0] &&
            filteredIngredients[1] == expectedValues[1] &&
            filteredIngredients[2] == expectedValues[2]
        )
    }
    
    func test_DessertDetailViewModel_formatOutput_shouldCapitalizeIngredientsAndDisplayMissingMeasurementMessage() {
        
        let dessert = MockData.mockDessertDetail
        let allIngredientValues =  dessertDetailVM.getIngredients(dessertDetail: dessert)
        let filteredIngredients = dessertDetailVM.removeNilOrEmptyIngredients(allIngredients: allIngredientValues)
        let formattedOutput = dessertDetailVM.formatOutput(ingredientArray: filteredIngredients)
        let expectedValues = [
            ("Test Ingredient 1", "1 cup"),
            ("Test Ingredient 2", "2 teaspoons"),
            ("Ingredient Without Measurement", "No measurement specified.")
        ]
        
        XCTAssertTrue(
            formattedOutput[0] == expectedValues[0] &&
            formattedOutput[1] == expectedValues[1] &&
            formattedOutput[2] == expectedValues[2]
        )
    }
}
