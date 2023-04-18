//
//  Dessert.swift
//  DessertApp
//
//  Created by Elise on 4/15/23.
//

import Foundation

struct Dessert: Decodable, Hashable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

struct DessertDetail: Decodable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
}

struct DessertResponse: Decodable {
    let meals: [Dessert]
}

struct DessertDetailResponse: Decodable {
    let meals: [DessertDetail]
}

struct MockData {
    
    static let mockDessert = Dessert(strMeal: "Test Dessert", strMealThumb: "", idMeal: "111")
    
    static let mockDessertDetail = DessertDetail(
        idMeal: "111",
        strMeal: "Test Dessert",
        strInstructions: "Test Instructions",
        strIngredient1: "Test ingredient 1",
        strIngredient2: "Test ingredient 2",
        strIngredient3: nil,
        strIngredient4: nil,
        strIngredient5: nil,
        strIngredient6: nil,
        strIngredient7: nil,
        strIngredient8: nil,
        strIngredient9: nil,
        strIngredient10: nil,
        strIngredient11: nil,
        strIngredient12: nil,
        strIngredient13: nil,
        strIngredient14: nil,
        strIngredient15: nil,
        strIngredient16: nil,
        strIngredient17: nil,
        strIngredient18: nil,
        strIngredient19: nil,
        strIngredient20: nil,
        strMeasure1: "1 cup",
        strMeasure2: "2 teaspoons",
        strMeasure3: nil,
        strMeasure4: nil,
        strMeasure5: nil,
        strMeasure6: nil,
        strMeasure7: nil,
        strMeasure8: nil,
        strMeasure9: nil,
        strMeasure10: nil,
        strMeasure11: nil,
        strMeasure12: nil,
        strMeasure13: nil,
        strMeasure14: nil,
        strMeasure15: nil,
        strMeasure16: nil,
        strMeasure17: nil,
        strMeasure18: nil,
        strMeasure19: nil,
        strMeasure20: nil
    )
}
