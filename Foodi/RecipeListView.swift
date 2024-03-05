//
//  ContentView.swift
//  Foodi
//
//  Created by Braden Smith on 2/28/24.
//

import SwiftUI
import Alamofire

///View model to power the recipe list.
public class RecipeListViewModel: NSObject, ObservableObject {
    
    //MARK:  - Properties -
    ///MealDB API Client
    let client = MealDBClient()
    
    //Initialize the meals array with 20 empty meals
    //This allows us to have a nice placeholder while waiting on API Data
    @Published public var meals: [Meal]
    @Published public var displayedMeals: [Meal]
    @Published public var searchText: String = ""
    @Published public var isLoading: Bool = true
    
    override init(){
        let meals = (0...50).map{ Meal(id: $0, name: Meal.placeholder.name) }
        self.meals = meals
        self.displayedMeals = meals
    }
    
    ///Fetch the list of meals from the API
    public func fetchDessertList() async {
        do{
            await self.setIsLoading(true)
            let meals = try await client.fetchMeals(forCategory: .dessert)
            //Update the meals array with the meals from the API
            await MainActor.run{
                self.meals = meals.sorted(by: {$0.name < $1.name})
                withAnimation(.bouncy){ self.displayedMeals = self.meals }
            }
            await self.setIsLoading(false)
        }catch{
            print(error)
            await self.setIsLoading(false)
        }
    }
    
    ///Fetch the details for a meal
    /// - Parameters: meal: The meal to fetch details for.
    /// Updates the meals array with the detailed meal.
    public func fetchDessertDetails(for meal: Meal) async {
        do{
            let detailedMeal = try await client.fetchMealDetails(for: meal.id)
            await MainActor.run{
                guard let mealIndex = self.meals.firstIndex(of: meal), let displayIndex = self.displayedMeals.firstIndex(of: meal) else { print("Meal not found"); return }
                self.meals[mealIndex] = detailedMeal
                withAnimation(.bouncy){ self.displayedMeals[displayIndex] = detailedMeal }
            }
        }catch{
            print(error)
        }
    }
    
    ///Filter the meals array by the search text
    public func filterBySearch(){
        if searchText.isEmpty{
            ///If the search text is empty, display all meals
            displayedMeals = meals
        }else{
            ///If the search text is not empty, display only the meals that contain the search text
            displayedMeals = meals.filter{ $0.searchQuery.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    ///Set the isLoading state
    public func setIsLoading(_ loading: Bool) async {
        await MainActor.run{
            self.isLoading = loading
        }
    }
    
}

struct RecipeListView: View {
    
    //Initialize our view model as a state object because we want to keep the view model alive as long as this list view is alive
    @StateObject private var viewModel = RecipeListViewModel()
    
    ///State for the search bar size - used to add space to top of list
    @State private var searchBarSize: CGSize = .zero
    ///Variable to read current horizontal size class
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .top){
                
                //List of Recipes
                //Make a Simple List for Constrained Size Classes
                if sizeClass == .compact{
                    List{
                        
                        //Spacer to account for the search bar
                        Spacer()
                            .frame(height: searchBarSize.height)
                            .listRowBackground(Color.white1)
                            .listRowSeparator(.hidden)
                            
                        //Iterate over the Recipes
                        ForEach(viewModel.displayedMeals){ meal in
                            NavigationLink(destination: {
                                MealDetailView(meal: .constant(meal))
                                    .task{
                                        print("I am fetching meal details for \(meal.name)")
                                        await self.viewModel.fetchDessertDetails(for: meal)
                                    }
                            }, label: {
                                MealCell(meal)
                            })
                            //Disable if in placholder mode
                            .disabled(viewModel.isLoading)
                            .listRowSeparatorTint(Color.lilac.opacity(0.5))
                            .foregroundColor(Color.lilac)
                            .listRowBackground(Color.white1)
                        }
                    }
                    .listStyle(.plain)
                    .placeholderAnimation(isLoading: viewModel.isLoading, loopDuration: 1.0)
                    
                }else{
                    
                    let gridItem = GridItem(.flexible(minimum: 150, maximum: 250), spacing: 15)
                    let gridItemCount: Int = 5
                    
                    ScrollView(.vertical){
                        LazyVGrid(columns: Array(repeating: gridItem, count: gridItemCount), spacing: 16){
                            //Iterate over the Recipes
                            ForEach(viewModel.displayedMeals){ meal in
                                NavigationLink(destination: {
                                    MealDetailView(meal: .constant(meal))
                                        .task{
                                            print("I am fetching meal details for \(meal.name)")
                                            await self.viewModel.fetchDessertDetails(for: meal)
                                        }
                                }, label: {
                                    MealCell(meal)
                                })
                                //Disable if in placholder mode
                                .disabled(viewModel.isLoading)
                                
                            }
                        }
                        .placeholderAnimation(isLoading: viewModel.isLoading, loopDuration: 1.0)
                        .padding(.top, searchBarSize.height)
                        .padding()
                    }
                }
                
                //Search Bar
                SearchBar(text: $viewModel.searchText)
                    .onChange(of: viewModel.searchText){ _ in
                        withAnimation(.bouncy){ viewModel.filterBySearch() }
                    }
                
            }
            .background(Color.white1)
        }
        .navigationViewStyle(.stack)
        .onPreferenceChange(SizePreferenceKey.self) { size in
            if let size = size {
                self.searchBarSize = size
            }
        }
        .task{
            //Fetch the list of desserts
            print("task for dessert list was called")
            await viewModel.fetchDessertList()
        }
        
    }
    
    var iphone: some View {
        Text("")
    }
    
}

#Preview {
    RecipeListView()
}
