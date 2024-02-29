//
//  MealCell.swift
//  Foodi
//
//  Created by Braden Smith on 2/29/24.
//

import SwiftUI

struct MealCell: View{
    
    init(_ meal: Meal){
        self.meal = meal
    }
    
    let meal: Meal
    
    var body: some View{
        HStack{
            Text(meal.name)
//                .body()
                .redacted(reason: meal.isPlaceHolder ? .placeholder : [])
        }
        .placeholderAnimation(isLoading: meal.isPlaceHolder)
        .foregroundColor(.purple)
    }
    
}

#Preview {
    MealCell(.placeholder)
}
