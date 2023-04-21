//
//  DessertListViewModelTests.swift
//  DessertAppTests
//
//  Created by Elise on 4/19/23.
//

import XCTest
@testable import DessertApp

@MainActor
final class DessertListViewModelTests: XCTestCase {
    
    let dessertListVM = DessertListViewModel()
    
    func test_DessertListViewModel_getDessertDetails_shouldPopulateDessertArray() async throws {
        Task {
            dessertListVM.getDessertList()
            XCTAssertFalse(dessertListVM.sortedDesserts.isEmpty, "Call should populate array with Dessert objects.")
        }
    }
    
    func test_DessertListViewModel_getDessertDetails_isLoading() async throws {
        Task {
            dessertListVM.getDessertList()
            XCTAssertTrue(dessertListVM.isLoading, "isLoading should be true while network call completes.")
        }
        XCTAssertFalse(dessertListVM.isLoading, "isLoading should be false after network call completes.")
    }
}
