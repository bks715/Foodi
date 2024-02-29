//
//  MealListResponse.swift
//  Foodi
//
//  Created by Braden Smith on 2/29/24.
//

import Foundation

/// `MealListResponse` is needed to decode the JSON response from the MealDB API.
struct MealListResponse: Decodable {
    /// An array of `Meal` objects representing the list of meals.
    let meals: [Meal]
}
