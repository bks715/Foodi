//
//  IngredientTests.swift
//  FoodiUITests
//
//  Created by Braden Smith on 2/29/24.
//

import XCTest
@testable import Foodi

final class IngredientTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //Test proper initialization of the Ingredient model
    func testIngredientInit() {
        let ingredient = Ingredient(name: "Baking Flour", measurement: "113 grams / 0.5 cups")
        XCTAssertEqual(ingredient.id, "baking_flour113_grams_/_0.5_cups")
        XCTAssertEqual(ingredient.name, "Baking Flour")
        XCTAssertEqual(ingredient.measurement, "113 grams / 0.5 cups")
    }
    
    //Test that the id generation works properly
    //The id should be the name of the ingredient with spaces replaced with underscores and all lowercase
    func testIngredientIdGeneration() {
        let bakingFlour = Ingredient(name: "Baking Flour", measurement: "113 grams / 0.5 cups")
        let butter = Ingredient(name: "BUTTER", measurement: "300 grams / 1 stick")
        let milk = Ingredient(name: "DaIRy_MiLk .", measurement: "240 grams / 1 cup")
        
        XCTAssertEqual(bakingFlour.id, "baking_flour113_grams_/_0.5_cups")
        XCTAssertEqual(butter.id, "butter300_grams_/_1_stick")
        XCTAssertEqual(milk.id, "dairy_milk_.240_grams_/_1_cup")
    }
    
    //Test that the ingredient Name is properly formatted
    func testIngredientNameFormatting() {
        let bakingFlour = Ingredient(name: "Baking Flour", measurement: "113 grams / 0.5 cups")
        let butter = Ingredient(name: "BUTTER", measurement: "300 grams / 1 stick")
        let milk = Ingredient(name: "DaIRy_MiLk .", measurement: "240 grams / 1 cup")
        
        XCTAssertEqual(bakingFlour.name, "Baking Flour")
        XCTAssertEqual(butter.name, "Butter")
        XCTAssertEqual(milk.name, "Dairy Milk .")
    }
    
    //Test Codable Conformance
    func testIngredientCodable() {
        let ingredients = [ Ingredient(name: "Baking Flour", measurement: "113 grams / 0.5 cups"),
                            Ingredient(name: "BUTTER", measurement: "300 grams / 1 stick"),
                            Ingredient(name: "DaIRy_MiLk .", measurement: "240 grams / 1 cup")]
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        do {
            try ingredients.forEach { ingredient in
                let data = try encoder.encode(ingredient)
                let decodedIngredient = try decoder.decode(Ingredient.self, from: data)
                XCTAssertEqual(ingredient, decodedIngredient)
            }
        } catch {
            XCTFail("Failed to encode or decode Ingredient: \(error.localizedDescription)")
        }
    }
    
    //Test Hashable Conformance
    func testIngredientHashable(){
        let ingredient = Ingredient(name: "Baking Flour", measurement: "113 grams / 0.5 cups")
        let ingredient2 = Ingredient(name: "Baking Flour", measurement: "113 grams / 0.5 cups")
        let ingredient3 = Ingredient(name: "Baking Flour", measurement: "1 metric ton")
        
        //The hash value of two equal ingredients should be the same
        XCTAssertEqual(ingredient.hashValue, ingredient2.hashValue)
        //Ensure that the hash value of the third ingredient is different
        XCTAssertNotEqual(ingredient.hashValue, ingredient3.hashValue)
        
        //The ingredient2 should be contained in a set if ingredient is in the set
        var ingredientSet = Set<Ingredient>()
        ingredientSet.insert(ingredient)
        XCTAssertTrue(ingredientSet.contains(ingredient2))
        
    }
    
    //Test Identifiable Conformance
    func testIngredientIdentifiable() {
        let ingredient = Ingredient(name: "Baking Flour", measurement: "113 grams / 0.5 cups")
        let ingredient2 = Ingredient(name: "Baking Flour", measurement: "1 metric ton")
        XCTAssertEqual(ingredient.id, "baking_flour113_grams_/_0.5_cups")
        XCTAssertEqual(ingredient2.id, "baking_flour1_metric_ton")
        XCTAssertNotEqual(ingredient.id, ingredient2.id)
    }

}
