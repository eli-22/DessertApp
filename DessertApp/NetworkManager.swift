//
//  NetworkManager.swift
//  DessertApp
//
//  Created by Elise on 4/15/23.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    let dessertListURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    // static? private?
    let dessertDetailBaseURL = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    @Published var alertItem: AlertItem?
    
    private init() {}
    
    func getDessertList() async throws -> [Dessert] {
        guard let url = URL(string: dessertListURL) else {
            throw DessertAppError.invalidURL
        }
        
        // Tuple of (Data, URLResponse). If nil, throws error.
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(DessertResponse.self, from: data)
            return decodedResponse.meals
        } catch {
            throw DessertAppError.invalidData
        }
    }
    
    func getDessertDetail(mealID: String) async throws -> [DessertDetail] {
        let urlString = dessertDetailBaseURL + mealID
        guard let url = URL(string: urlString) else {
            throw DessertAppError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(DessertDetailResponse.self, from: data)
            return decodedResponse.meals
        } catch {
            throw DessertAppError.invalidData
        }
    }
}
