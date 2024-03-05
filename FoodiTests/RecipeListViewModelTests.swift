//
//  RecipeListViewModelTests.swift
//  FoodiTests
//
//  Created by Braden Smith on 3/5/24.
//

import XCTest
@testable import Foodi

final class RecipeListViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //Ensure that initializing the view model occurs properly and creates placeholders while data is loading
    func testInitialization() {
        let viewModel = RecipeListViewModel()
        XCTAssertNotNil(viewModel)
        //Test that the placeholders are created
        XCTAssertTrue(viewModel.displayedMeals.count == 50)
        XCTAssertTrue(viewModel.displayedMeals.allSatisfy({ $0.isPlaceHolder }))
        //Ensure that actionable Error is nil
        XCTAssertNil(viewModel.actionableError)
    }
    
    //Ensure that searching works correctly
    func testSearch() async {
        let viewModel = RecipeListViewModel()
        //Fetch the dessert list
        await viewModel.fetchDessertList()
        //Test that searching for a meal that exists works
        viewModel.searchText = "Apple"
        //Search
        viewModel.filterBySearch()
        XCTAssertTrue(viewModel.displayedMeals.allSatisfy({ $0.name.lowercased().contains("apple") }))
        //Test that searching for a meal that doesn't exist works
        viewModel.searchText = "1234567890"
        //Search
        viewModel.filterBySearch()
        XCTAssertTrue(viewModel.displayedMeals.isEmpty)
    }

}
