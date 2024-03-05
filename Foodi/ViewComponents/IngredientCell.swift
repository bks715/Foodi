//
//  IngredientCell.swift
//  Foodi
//
//  Created by Braden Smith on 3/5/24.
//

import SwiftUI

/// A view component that displays an ingredient with its name and measurement.
struct IngredientCell: View {
    
    /// The ingredient to be displayed.
    let ingredient: Ingredient
    
    /// The body of the `IngredientCell` view.
    var body: some View {
        HStack{
            Text(ingredient.name)
                .foregroundStyle(Color.primaryText)
            Spacer()
            Text(ingredient.measurement)
                .headline()
        }
        .body()
        .foregroundStyle(Color.primaryText)
        .padding(10)
        .background(Material.ultraThin)
        .cornerRadius(5)
        .shadow(radius: 6, y: 0)
    }
}

#Preview {
    IngredientCell(ingredient: Meal.mockMeal.ingredients!.first!)
}
