//
//  MealDBClient.swift
//  Foodi
//
//  Created by Braden Smith on 2/29/24.
//

import Foundation
import Alamofire

public actor MealDBClient: NSObject {
    
    //MARK: - Properties -
    
    ///An in-memory cache for meals that have already had their details fetched.
    ///Used to reduce the number of API requests.
    private var detailedMealCache: Set<Meal> = []
    
    //MARK: - API Request Methods -
    
    ///Fetch a list of meals from the MealDB API.
    /// - Parameters: category: The category of meals to fetch.
    /// - Returns: A list of meals from the MealDB API.
    /// - Throws: An error if the request fails.
    public func fetchMeals(forCategory category: Category) async throws -> [Meal] {
        ///Convert the category into a parameter
        let parameters = [category.queryItem()]
        ///Create the endpoint URL
        let endpointURL = try self.url(for: .list, parameters: parameters)
        ///Create the request
        let request = AF.request(endpointURL).validate().serializingDecodable(MealListResponse.self)
        ///Wait for the response
        //Using response instead of value in case printing response is needed for debugging
        let response = await request.response
        ///Return the meals after unwrapping them from the response
        guard let mealListResponse = response.value else { throw MealDBError.invalidResponse}
        return mealListResponse.meals
    }
    
    ///Fetch a meal from the MealDB API by its id.
    /// - Parameters: id: The unique identifier for the meal.
    /// - Returns: A meal from the MealDB API.
    /// - Throws: An error if the request fails.
    public func fetchMealDetails(for id: Int) async throws -> Meal {
        ///Check the cache for the meal
        if let meal = detailedMealCache.first(where: { $0.id == id }) {
            return meal
        }
        let parameters = [URLQueryItem(name: "i", value: String(id))]
        ///Create the endpoint URL
        let endpointURL = try self.url(for: .lookup, parameters: parameters)
        ///Create the request
        let request = AF.request(endpointURL).validate().serializingDecodable(MealListResponse.self)
        ///Wait for the response
        let response = await request.response
        ///Return the meal after unwrapping it from the response
        guard let mealListResponse = response.value, let meal = mealListResponse.meals.first else { throw MealDBError.invalidData }
        ///Update the cache with the meal
        self.updateCache(with: [meal])
        return meal
    }
    
    ///Update the cache with the given meals.
    /// - Parameters: meals: The meals to add to the cache.
    private func updateCache(with meals: [Meal]) {
        detailedMealCache.formUnion(meals)
    }
    
    fileprivate func fetchFromCache(id: Int) -> Meal? {
        return detailedMealCache.first(where: { $0.id == id })
    }
    
}

//MARK: - Endpoints, Options, and URL Construction -
extension MealDBClient {
    
    ///Endpoints for the MealDB API
    public enum Endpoints: String {
        ///List all meals
        case list = "filter.php"
        ///Lookup a meal by id
        case lookup = "lookup.php"
    }
    
    ///Categories of Meal types for the MealDB API
    public enum Category: String {
        case dessert = "Dessert"
        
        ///The query item for the category.
        func queryItem() -> URLQueryItem {
            return URLQueryItem(name: "c", value: self.rawValue)
        }
    }
    
    ///Crafts a URL for the given endpoint and parameters.
    /// - Parameters:
    /// - endpoint: The endpoint to use.
    /// - parameters: The parameters to include in the URL.
    /// - Returns: A URL for the given endpoint and parameters.
    private func url(for endpoint: Endpoints, parameters: [URLQueryItem] = []) throws -> URL {
        let baseURL = "https://www.themealdb.com/api/json/v1/1/"
        var components = URLComponents(string: baseURL + endpoint.rawValue)!
        components.queryItems = parameters
        
        // Ensure the URL is valid.
        guard let url = components.url else { throw MealDBError.invalidURL }
        return url
    }
    
}

//MARK: Error Handling -
extension MealDBClient {
    ///An error that can occur when interacting with the MealDB API.
    enum MealDBError: Error, LocalizedError {
        ///The request failed.
        case requestFailed
        ///The response was not valid JSON.
        case invalidResponse
        ///The response did not contain the expected data.
        case invalidData
        ///The URL is invalid.
        case invalidURL
        
        ///A description for the error.
        var errorDescription: String? {
            switch self {
            case .requestFailed:
                return "The request failed."
            case .invalidResponse:
                return "The response was not valid JSON."
            case .invalidData:
                return "The response did not contain the expected data."
            case .invalidURL:
                return "The URL is invalid."
            }
        }
    }
}
