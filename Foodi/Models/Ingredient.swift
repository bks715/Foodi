//
//  Ingredient.swift
//  Foodi
//
//  Created by Braden Smith on 2/29/24.
//

import Foundation


/// A model representing an ingredient with its associated properties.
public struct Ingredient: Codable, Hashable, Identifiable {
    
    /// The unique identifier for the ingredient.
    ///  Although the meal db does assign a number id to the ingredients you can query ingredients by their name (replacing spaces with underscores) so I will use the name as the id.
    public let id: String
    /// The name of the ingredient.
    public let name: String
    /// The measurement unit for the ingredient.
    public let measurement: String
    
    /// A custom initializer for creating an `Ingredient` model without an `id`.
    /// - Parameters:
    ///  - name: The name of the ingredient.
    ///  - measurement: The measurement unit for the ingredient.
    public init(name: String, measurement: String) {
        // Create a unique identifier for the ingredient by converting the name to lowercase and replacing spaces with underscores.
        self.id = (name + measurement).lowercased().replacingOccurrences(of: " ", with: "_")
        // Capitalize the first letter of each word in the name and replace underscores with spaces.
        self.name = name.replacingOccurrences(of: "_", with: " ").capitalized(with: .current)
        self.measurement = measurement
    }
    
}
