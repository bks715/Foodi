//
//  MealCell.swift
//  Foodi
//
//  Created by Braden Smith on 2/29/24.
//

import SwiftUI
import Kingfisher

struct MealCell: View{
    
    init(_ meal: Meal){
        self.meal = meal
    }
    
    let meal: Meal
    
    var body: some View{
        HStack(alignment: .center, spacing: 15){
            ///Load the image from the URL if available
            if let imgURL = meal.thumbnailURL{
                KFImage(URL(string: imgURL))
                    .resizable()
                    .placeholder({ prog in
                        Color.lilac
                            .overlay{
                                ProgressView()
                                    .tint(Color(hex: "F6E8AC"))
                            }
                    })
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.12), radius: 6, x: 3, y: 5)
            }else{
                Color.lilac
                    .opacity(0.5)
                    .frame(width: 44, height: 44)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.12), radius: 6, x: 3, y: 5)
            }
            Text(meal.name.capitalized)
                .font(.dmSans(size: 19, style: .headline, weight: .medium))
                .foregroundStyle(Color.primaryText)
                .redacted(reason: meal.isPlaceHolder ? .placeholder : [])
            
            Spacer()
            
        }
        .placeholderAnimation(isLoading: meal.isPlaceHolder)
    }
    
}

#Preview {
    RecipeListView()
}
