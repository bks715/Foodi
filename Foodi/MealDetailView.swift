//
//  MealDetailView.swift
//  Foodi
//
//  Created by Braden Smith on 3/1/24.
//

import SwiftUI
import Kingfisher
import Vision
import VideoToolbox

struct MealDetailView: View{
    
    //Binded Meal that contains the information for the view
    @Binding var meal: Meal
    //Horizontal Size Class
    @Environment(\.horizontalSizeClass) var sizeClass
    //View state
    @State private var viewState: MealDetailViewState = .ingredients
    
    var body: some View{
        
        GeometryReader{ geo in
            ZStack(alignment: .top) {
                //MARK: Image -
                if let imgURL = meal.thumbnailURL{
                    ZStack{
                        //Background Image
                        KFImage(URL(string: imgURL))
                            .resizable()
                            .placeholder({ prog in
                                Color.lilac
                                    .overlay{
                                        ProgressView()
                                            .tint(Color(hex: "F6E8AC"))
                                    }
                            })
                            .scaledToFill()
                            .frame(width: geo.size.width)
                        
                        //Segmented Cutout Overlay of Image Subject
                        KFImage(URL(string: imgURL))
                            .resizable()
                            .placeholder({ prog in
                                Color.lilac
                                    .overlay{
                                        ProgressView()
                                            .tint(Color(hex: "F6E8AC"))
                                    }
                            })
                            .imageModifier(SegmentationImageModifier())
                            .scaledToFill()
                            .frame(width: geo.size.width, height: geo.size.height * (sizeClass == .regular ? 0.4 : 0.3))
                            .background{
                                Rectangle()
                                    .fill(Material.ultraThin)
                                    .frame(width: geo.size.width, height: geo.size.height)
                                    .ignoresSafeArea()
                            }
                            .shadow(radius: 5)
                    }
                    .frame(height: geo.size.height * (sizeClass == .regular ? 0.45 : 0.35))
                }else{
                    Color.lilac
                        .opacity(0.5)
                        .frame(width: 44, height: 44)
                        .cornerRadius(8)
                        .shadow(color: .black.opacity(0.12), radius: 6, x: 3, y: 5)
                }
                
                //MARK: Scroll View & Text -
                ScrollView(.vertical) {
                    VStack(spacing: 0){
                        
                        Spacer()
                            .frame(height: geo.size.height * (sizeClass == .regular ? 0.4 : 0.3) - 20)
                        
                        VStack(alignment: .leading, spacing: 15){
                            
                            //Title and Selector
                            VStack(alignment: .leading, spacing: 5){
                                Text(meal.name)
                                    .foregroundStyle(Color.primaryText)
                                    .font(.dmSans(size: 24, style: .title, weight: .bold))
                                
                                //Ingredient - Instruction Selector
                                ///Custom Binding that maps the View State Value to and from String
                                let viewStateBinding: Binding<String> = .init(get: {self.viewState.rawValue}, set: {
                                    if let value = MealDetailViewState(rawValue: $0){
                                        self.viewState = value
                                    }
                                })
                                SlidingPickerView(selection: viewStateBinding, values: MealDetailViewState.allCases.map{$0.rawValue})
                            }
                            .padding(.bottom, 10)
                            
                            switch self.viewState {
                            case .ingredients:
                                if let ingredients = meal.ingredients{
                                    VStack(alignment: .leading, spacing: 10){
                                        ForEach(ingredients, id: \.self){ ingredient in
                                            IngredientCell(ingredient: ingredient)
                                        }
                                        
                                        //Bottom Padding
                                    }
                                }else{
                                    //No Ingredients Available
                                }
                            case .instructions:
                                Text(meal.instructions ?? "")
                                    .body()
                            }
                            
                            Spacer()
                                .frame(minHeight: 200)
                        }
                        .padding()
                        .background(Material.thin)
                        .cornerRadius(10, corners: [.topLeft, .topRight])
                        .shadow(radius: 5, y: -1)
                        
                    }
                    
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
    }
    
}

//MARK: ViewState Enum for Meal Detail View -
fileprivate enum MealDetailViewState: String, CaseIterable {
    case ingredients, instructions
}

#Preview {
    MealDetailView(meal: .constant(.mockMeal))
}
