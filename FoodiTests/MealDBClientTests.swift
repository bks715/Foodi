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
    
    func testMealDetailsFailure() async throws {
        //Make sure an error is thrown that says invalid data
        do{
            let mealDetails = try await self.mealDBClient.fetchMealDetails(for: 1234567890)
            XCTFail("Expected MealDBError.invalidData to be thrown")
        }catch{
            XCTAssertEqual(error as? MealDBClient.MealDBError, MealDBClient.MealDBError.invalidData)
        }
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
