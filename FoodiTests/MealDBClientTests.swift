//
//  MealDBClientTests.swift
//  FoodiTests
//
//  Created by Braden Smith on 2/29/24.
//

import XCTest
@testable import Foodi

final class MealDBClientTests: XCTestCase {

    var mealDBClient: MealDBClient!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mealDBClient = MealDBClient()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mealDBClient = nil
    }

    func testMealListFetching() async throws {
        let meals = try await mealDBClient.fetchMeals(forCategory: .dessert)
        XCTAssertFalse(meals.isEmpty)
    }
    
    //Test that the appropriate meal details for different meals
    func testMealDetailsFetching() async throws {
        let meals = try await mealDBClient.fetchMeals(forCategory: .dessert)
        //Test that the meal details can be fetched for 5 random meals
        let randomMeals = meals.shuffled().prefix(5)
        for meal in randomMeals {
            let mealDetails = try await mealDBClient.fetchMealDetails(for: meal.id)
            XCTAssertNotNil(mealDetails)
            XCTAssertEqual(meal.id, mealDetails.id)
            XCTAssertEqual(meal.thumbnailURL, mealDetails.thumbnailURL)
            XCTAssertEqual(meal.name, mealDetails.name)
            XCTAssertNotNil(mealDetails.ingredients)
            XCTAssertNotNil(mealDetails.instructions)
        }
    }
    
    //Test that an error is thrown when fetching meal details for an invalid meal id
    func testMealDetailsFailure() async throws {
        //Make sure an error is thrown that says invalid data
        do{
            let _ = try await self.mealDBClient.fetchMealDetails(for: 1234567890)
            XCTFail("Expected MealDBError.invalidData to be thrown")
        }catch{
            XCTAssertEqual(error as? MealDBClient.MealDBError, MealDBClient.MealDBError.invalidData)
        }
    }

    //Test the the right endpoint is created for each category
    func testCategoryEndpoints() async throws {
        let categories = MealDBClient.Category.allCases
        for category in categories{
            let endpointURL = try await  mealDBClient.url(for: .list, parameters: [category.queryItem()])
            //Check that the endpoint URL is correct for each category
            XCTAssertEqual(endpointURL, URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category.rawValue)"))
        }
    }
    
    //Test the URL building function
    func testURLBuilder() async throws {
        //Test for listing recipes by category
        let listGroundTruth = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        let listURL = try await mealDBClient.url(for: .list, parameters: [MealDBClient.Category.dessert.queryItem()])
        XCTAssertEqual(listURL, listGroundTruth)
        
        //Test for looking up a recipe by id
        let lookupGroundTruth = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=1")!
        let lookupURL = try await mealDBClient.url(for: .lookup, parameters: [URLQueryItem(name: "i", value: "1")])
        XCTAssertEqual(lookupURL, lookupGroundTruth)
    }

}
