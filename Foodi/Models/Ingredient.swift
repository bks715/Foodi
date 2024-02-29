//
//  Ingredient.swift
//  Foodi
//
//  Created by Braden Smith on 2/29/24.
//

import Foundation


/// A model representing an ingredient with its associated properties.
struct Ingredient: Codable, Hashable, Identifiable {
    
    /// The unique identifier for the ingredient.
    ///  Although the meal db does assign a number id to the ingredients you can query ingredients by their name (replacing spaces with underscores) so I will use the name as the id.
    let id: String
    /// The name of the ingredient.
    let name: String
    /// The measurement unit for the ingredient.
    let measurement: String
    
    /// A custom initializer for creating an `Ingredient` model without an `id`.
    /// - Parameters:
    ///  - name: The name of the ingredient.
    ///  - measurement: The measurement unit for the ingredient.
    init(name: String, measurement: String) {
        // Create a unique identifier for the ingredient by converting the name to lowercase and replacing spaces with underscores.
        self.id = name.lowercased().replacingOccurrences(of: " ", with: "_")
        self.name = name
        self.measurement = measurement
    }
    
}
