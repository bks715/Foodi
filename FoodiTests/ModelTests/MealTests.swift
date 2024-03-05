//
//  MealTests.swift
//  FoodiUITests
//
//  Created by Braden Smith on 2/29/24.
//

import XCTest
@testable import Foodi

final class MealTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //Test proper initialization of the Meal model
    func testMealInitialization() throws {
        //Test with a Fully Populated Meal
        let populatedMeal = Meal(id: 100, name: "Pasta", category: "Italian", area: "Italy", instructions: "Boil pasta", thumbnailURL: "http://example.com/image.jpg", tags: ["easy", "quick"], youtubeURL: "http://youtube.com/watch?v=abc", sourceURL: "http://example.com/recipe", ingredients: [Ingredient(name: "Cheese", measurement: "1 Cup")])
        XCTAssertEqual(populatedMeal.id, 100)
        XCTAssertEqual(populatedMeal.name, "Pasta")
        XCTAssertEqual(populatedMeal.category, "Italian")
        XCTAssertEqual(populatedMeal.area, "Italy")
        XCTAssertEqual(populatedMeal.instructions, "Boil pasta")
        XCTAssertEqual(populatedMeal.thumbnailURL, "http://example.com/image.jpg")
        XCTAssertEqual(populatedMeal.tags, ["easy", "quick"])
        XCTAssertEqual(populatedMeal.youtubeURL, "http://youtube.com/watch?v=abc")
        XCTAssertEqual(populatedMeal.sourceURL, "http://example.com/recipe")
        XCTAssertEqual(populatedMeal.ingredients, [Ingredient(name: "Cheese", measurement: "1 Cup")])
        
        //Test with a Minimal Meal
        let minimalMeal = Meal(id: 101, name: "Nacho Bell Grande")
        XCTAssertEqual(minimalMeal.id, 101)
        XCTAssertEqual(minimalMeal.name, "Nacho Bell Grande")
        XCTAssertNil(minimalMeal.category)
        XCTAssertNil(minimalMeal.area)
        XCTAssertNil(minimalMeal.instructions)
        XCTAssertNil(minimalMeal.thumbnailURL)
        XCTAssertNil(minimalMeal.tags)
        XCTAssertNil(minimalMeal.youtubeURL)
        XCTAssertNil(minimalMeal.sourceURL)
        XCTAssertNil(minimalMeal.ingredients)
    }
    
    //Mock JSON Data copied from the API
    let mockJsonData = """
    {"idMeal":"52768","strMeal":"Apple Frangipan Tart","strDrinkAlternate":null,"strCategory":"Dessert","strArea":"British","strInstructions":"Preheat the oven to 200C\\/180C Fan\\/Gas 6.\\r\\nPut the biscuits in a large re-sealable freezer bag and bash with a rolling pin into fine crumbs. Melt the butter in a small pan, then add the biscuit crumbs and stir until coated with butter. Tip into the tart tin and, using the back of a spoon, press over the base and sides of the tin to give an even layer. Chill in the fridge while you make the filling.\\r\\nCream together the butter and sugar until light and fluffy. You can do this in a food processor if you have one. Process for 2-3 minutes. Mix in the eggs, then add the ground almonds and almond extract and blend until well combined.\\r\\nPeel the apples, and cut thin slices of apple. Do this at the last minute to prevent the apple going brown. Arrange the slices over the biscuit base. Spread the frangipane filling evenly on top. Level the surface and sprinkle with the flaked almonds.\\r\\nBake for 20-25 minutes until golden-brown and set.\\r\\nRemove from the oven and leave to cool for 15 minutes. Remove the sides of the tin. An easy way to do this is to stand the tin on a can of beans and push down gently on the edges of the tin.\\r\\nTransfer the tart, with the tin base attached, to a serving plate. Serve warm with cream, crème fraiche or ice cream.","strMealThumb":"https:\\/\\/www.themealdb.com\\/images\\/media\\/meals\\/wxywrq1468235067.jpg","strTags":"Tart,Baking,Fruity","strYoutube":"https:\\/\\/www.youtube.com\\/watch?v=rp8Slv4INLk","strIngredient1":"digestive biscuits","strIngredient2":"butter","strIngredient3":"Bramley apples","strIngredient4":"butter, softened","strIngredient5":"caster sugar","strIngredient6":"free-range eggs, beaten","strIngredient7":"ground almonds","strIngredient8":"almond extract","strIngredient9":"flaked almonds","strIngredient10":"","strIngredient11":"","strIngredient12":"","strIngredient13":"","strIngredient14":"","strIngredient15":"","strIngredient16":null,"strIngredient17":null,"strIngredient18":null,"strIngredient19":null,"strIngredient20":null,"strMeasure1":"175g\\/6oz","strMeasure2":"75g\\/3oz","strMeasure3":"200g\\/7oz","strMeasure4":"75g\\/3oz","strMeasure5":"75g\\/3oz","strMeasure6":"2","strMeasure7":"75g\\/3oz","strMeasure8":"1 tsp","strMeasure9":"50g\\/1¾oz","strMeasure10":"","strMeasure11":"","strMeasure12":"","strMeasure13":"","strMeasure14":"","strMeasure15":"","strMeasure16":null,"strMeasure17":null,"strMeasure18":null,"strMeasure19":null,"strMeasure20":null,"strSource":null,"strImageSource":null,"strCreativeCommonsConfirmed":null,"dateModified":null}
    """

    //Test proper decoding of the Meal model from MealsDB API JSON
    func testMealDecoding() throws {
        //Convert the JSON string to JSON Data
        let jsonB = mockJsonData.data(using: .utf8)!
        //Decode the JSON Data to a Meal
        let meal = try JSONDecoder().decode(Meal.self, from: jsonB)
        //Test the Meal's properties
        XCTAssertEqual(meal.id, 52768)
        XCTAssertEqual(meal.name, "Apple Frangipan Tart")
        XCTAssertEqual(meal.category, "Dessert")
        XCTAssertEqual(meal.area, "British")
        XCTAssertEqual(meal.instructions, "Preheat the oven to 200C/180C Fan/Gas 6.\r\nPut the biscuits in a large re-sealable freezer bag and bash with a rolling pin into fine crumbs. Melt the butter in a small pan, then add the biscuit crumbs and stir until coated with butter. Tip into the tart tin and, using the back of a spoon, press over the base and sides of the tin to give an even layer. Chill in the fridge while you make the filling.\r\nCream together the butter and sugar until light and fluffy. You can do this in a food processor if you have one. Process for 2-3 minutes. Mix in the eggs, then add the ground almonds and almond extract and blend until well combined.\r\nPeel the apples, and cut thin slices of apple. Do this at the last minute to prevent the apple going brown. Arrange the slices over the biscuit base. Spread the frangipane filling evenly on top. Level the surface and sprinkle with the flaked almonds.\r\nBake for 20-25 minutes until golden-brown and set.\r\nRemove from the oven and leave to cool for 15 minutes. Remove the sides of the tin. An easy way to do this is to stand the tin on a can of beans and push down gently on the edges of the tin.\r\nTransfer the tart, with the tin base attached, to a serving plate. Serve warm with cream, crème fraiche or ice cream.")
        XCTAssertEqual(meal.thumbnailURL, "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg")
        XCTAssertEqual(meal.tags, ["Tart","Baking","Fruity"])
        XCTAssertEqual(meal.youtubeURL, "https://www.youtube.com/watch?v=rp8Slv4INLk")
        XCTAssertEqual(meal.sourceURL, nil)
        
        //Test the Meal's Ingredients
        let properIngredients = [Ingredient(name: "digestive biscuits", measurement: "175g/6oz"),
                                        Ingredient(name: "butter", measurement: "75g/3oz"),
                                        Ingredient(name: "Bramley apples", measurement: "200g/7oz"),
                                        Ingredient(name: "butter, softened", measurement: "75g/3oz"),
                                        Ingredient(name: "caster sugar", measurement: "75g/3oz"),
                                        Ingredient(name: "free-range eggs, beaten", measurement: "2"),
                                        Ingredient(name: "ground almonds", measurement: "75g/3oz"),
                                        Ingredient(name: "almond extract", measurement: "1 tsp"),
                                 Ingredient(name: "flaked almonds", measurement: "50g/1¾oz")].sorted(by: { $0.name < $1.name })
        
        //Check that the meal's ingredients are the same as the proper ingredients
        guard let mealIngredients = meal.ingredients else { throw XCTestError(_nsError: .init(domain: "Meal doesn't contain ingredients.", code: 102)) }
        XCTAssertEqual(properIngredients.count, mealIngredients.count)
        mealIngredients.forEach{ mealIngrient in
            XCTAssertTrue(properIngredients.contains(mealIngrient))
        }
        
    }
    
    //Encoding is not used in the app right now so not going to test it to save time
    
    //MARK: - Hashable & Identifiable Testing
    
    func testMealHashable() throws {
        //Use the decoded meal
        let jsonB = mockJsonData.data(using: .utf8)!
        let meal = try JSONDecoder().decode(Meal.self, from: jsonB)
        
        let properIngredients = [Ingredient(name: "digestive biscuits", measurement: "175g/6oz"),
                                        Ingredient(name: "butter", measurement: "75g/3oz"),
                                        Ingredient(name: "Bramley apples", measurement: "200g/7oz"),
                                        Ingredient(name: "butter, softened", measurement: "75g/3oz"),
                                        Ingredient(name: "caster sugar", measurement: "75g/3oz"),
                                        Ingredient(name: "free-range eggs, beaten", measurement: "2"),
                                        Ingredient(name: "ground almonds", measurement: "75g/3oz"),
                                        Ingredient(name: "almond extract", measurement: "1 tsp"),
                                        Ingredient(name: "flaked almonds", measurement: "50g/1¾oz")]
        let meal2 = Meal(id: 52768, name: "Apple Frangipan Tart", category: "Dessert", area: "British", instructions: "Preheat the oven to 200C/180C Fan/Gas 6.\r\nPut the biscuits in a large re-sealable freezer bag and bash with a rolling pin into fine crumbs. Melt the butter in a small pan, then add the biscuit crumbs and stir until coated with butter. Tip into the tart tin and, using the back of a spoon, press over the base and sides of the tin to give an even layer. Chill in the fridge while you make the filling.\r\nCream together the butter and sugar until light and fluffy. You can do this in a food processor if you have one. Process for 2-3 minutes. Mix in the eggs, then add the ground almonds and almond extract and blend until well combined.\r\nPeel the apples, and cut thin slices of apple. Do this at the last minute to prevent the apple going brown. Arrange the slices over the biscuit base. Spread the frangipane filling evenly on top. Level the surface and sprinkle with the flaked almonds.\r\nBake for 20-25 minutes until golden-brown and set.\r\nRemove from the oven and leave to cool for 15 minutes. Remove the sides of the tin. An easy way to do this is to stand the tin on a can of beans and push down gently on the edges of the tin.\r\nTransfer the tart, with the tin base attached, to a serving plate. Serve warm with cream, crème fraiche or ice cream.", thumbnailURL: "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg", tags: ["Tart","Baking","Fruity"], youtubeURL: "https://www.youtube.com/watch?v=rp8Slv4INLk", sourceURL: nil, ingredients: properIngredients.sorted(by: { $0.name < $1.name }))
        
        //Make sure the meals are equal by hash
        XCTAssertEqual(meal, meal2)
        
        //Make sure the the set contains the meal
        var mealSet: Set<Meal> = [meal]
        mealSet.insert(meal)
        XCTAssertEqual(mealSet.count, 1)
    }
    
    //Test identifiable
    func testMealIdentifiable() throws {
        //Use the decoded meal
        let jsonB = mockJsonData.data(using: .utf8)!
        let meal = try JSONDecoder().decode(Meal.self, from: jsonB)
        let meal2 = Meal(id: 52768, name: "Apple Frangipan Tart", category: "Dessert", area: "British")
        XCTAssertEqual(meal.id, meal2.id)
    }

}
