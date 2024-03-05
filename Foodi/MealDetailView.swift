//
//  MealDetailView.swift
//  Foodi
//
//  Created by Braden Smith on 3/1/24.
//

import SwiftUI
import Kingfisher

///A SwiftUI View that displays the details of a recipe including its ingredients and instructions for preparation.
///- Parameters:
///- meal: The meal to display the details for
struct MealDetailView: View{
    
    //Binded Meal that contains the information for the view
    @Binding var meal: Meal
    //Horizontal Size Class
    @Environment(\.horizontalSizeClass) var sizeClass
    //View state
    @State private var viewState: MealDetailViewState = .ingredients
    //Dismiss Action
    @Environment(\.dismiss) var dismiss
    
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
                                Text(meal.name.capitalized)
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
                                    .accessibilityLabel(Text("Select Ingredients or Instructions"))
                            }
                            .padding(.bottom, 10)
                            
                            //Ingredients or Instructions
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
                                    Text("No Ingredients Available")
                                        .foregroundStyle(Color.primaryText)
                                        .body()
                                        .frame(width: geo.size.width-30, height: geo.size.height*0.4)
                                }
                            case .instructions:
                                Text(meal.instructions ?? "Instructions Not Available")
                                    .body()
                                    .lineSpacing(10)
                                    .textSelection(.enabled)
                                    .foregroundStyle(Color.primaryText)
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
                
                //MARK: Back Button -
                HStack(alignment: .top, content: {
                    Button(action: { withAnimation{ self.dismiss()} }, label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color.primaryText)
                            .padding(10)
                            .background(Material.thin)
                            .clipShape(Circle())
                            .shadow(radius: 5, y: 1)
                    })
                    Spacer()
                })
                .padding(.horizontal)
                
            }//End z Stack
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

