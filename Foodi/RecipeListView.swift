//
//  ContentView.swift
//  Foodi
//
//  Created by Braden Smith on 2/28/24.
//

import SwiftUI

///View model to power the recipe list.
class RecipeListViewModel: NSObject, ObservableObject {
    
    //MARK:  - Properties -
    
    //Initialize the meals array with 20 empty meals
    //This allows us to have a nice placeholder while waiting on API Data
    @Published var meals = (0...20).map{ _ in Meal.placeholder }
    
}

struct RecipeListView: View {
    
    //Initialize our view model as a state object because we want to keep the view model alive as long as this list view is alive
    @StateObject private var viewModel = RecipeListViewModel()
    
    var body: some View {
        VStack{
            //Leave Space for Search Bar
            
            //List of Recipes
            List{
                //Iterate over the Recipes
                ForEach(viewModel.meals){ meal in
                    MealCell(meal)
                }
            }
            .listStyle(.plain)
        }
    }
    
}

#Preview {
    RecipeListView()
}
