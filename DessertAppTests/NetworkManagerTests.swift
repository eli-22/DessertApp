//
//  NetworkManagerTests.swift
//  DessertAppTests
//
//  Created by Elise on 4/19/23.
//

import XCTest
@testable import DessertApp

class NetworkManagerTests: XCTestCase {
    
    private let networkManager = NetworkManager.shared
    private let dessertListURL = NetworkManager.shared.dessertListURL
    private let dessertDetailBaseURL = NetworkManager.shared.dessertDetailBaseURL
    
    // MARK: URL tests
    func test_NetworkManager_getDessertList_correctURL() {
        XCTAssertEqual(dessertListURL, "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")
    }
    
    func test_NetworkManager_getDessertDetail_correctURL() {
        XCTAssertEqual(dessertDetailBaseURL, "https://themealdb.com/api/json/v1/1/lookup.php?i=")
    }
    
    // MARK: Error tests
    func test_NetworkManager_getDessertList_shouldThrowInvalidURLError() async throws {
        let invalidURL = ""
        do {
            _ = try await networkManager.getDessertList(url: invalidURL)
            XCTFail("Call should throw an invalidURL error.")
        } catch let error as DessertAppError {
            XCTAssertEqual(error, DessertAppError.invalidURL)
        }
    }
    
    func test_NetworkManager_getDessertList_shouldThrowInvalidDataError() async throws {
        let noDataURL = "https://www.google.com"
        do {
            _ = try await networkManager.getDessertList(url: noDataURL)
            XCTFail("Call should throw an invalidData error.")
        } catch let error as DessertAppError {
            XCTAssertEqual(error, DessertAppError.invalidData)
        }
    }
    
    func test_NetworkManager_getDessertDetail_shouldThrowInvalidURLError() async throws {
        let invalidURL = ""
        do {
            _ = try await networkManager.getDessertList(url: invalidURL)
            XCTFail("Call should throw an invalidURL error.")
        } catch let error as DessertAppError {
            XCTAssertEqual(error, DessertAppError.invalidURL)
        }
    }
    
    func test_NetworkManager_getDessertDetail_shouldThrowInvalidDataError() async throws {
        let noDataURLMissingMealID = dessertDetailBaseURL
        do {
            _ = try await networkManager.getDessertList(url: noDataURLMissingMealID)
            XCTFail("Call should throw an invalidData error.")
        } catch let error as DessertAppError {
            XCTAssertEqual(error, DessertAppError.invalidData)
        }
    }
    
    // MARK: Result tests
    func testNetworkManager_getDessertList_shouldReturnDessertArray() async throws {
        let desserts = try await networkManager.getDessertList(url: NetworkManager.shared.dessertListURL)
        XCTAssertNotNil(desserts, "Call should return array of Dessert objects.")
    }
    
    func testNetworkManager_getDessertDetail_shouldReturnDessertDetailArray() async throws {
        let mealID = "53049"
        let url = dessertDetailBaseURL + mealID
        let dessertDetail = try await networkManager.getDessertList(url: url)
        XCTAssertNotNil(dessertDetail, "Call should return array with details for one dessert.")
    }
}


