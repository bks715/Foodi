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
    
    //Horizontal Size Class Variable
    @Environment(\.horizontalSizeClass) var sizeClass
    
    let meal: Meal
    
    var body: some View{
        //Layout as a Cell for compact View Classes eg. iPhone
        if sizeClass == .compact{
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
        } else {
            //Layout as a Grid Square for Larger Horizontal View Class eg. Full Screen on iPad
            HStack(){
                Spacer()
                
                VStack(alignment: .center, spacing: 15){
                    Spacer()
                    
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
                
                Spacer()
            }
            .background(Color.white2)
            .cornerRadius(8)
        }
    }
    
}

#Preview {
    RecipeListView()
}
