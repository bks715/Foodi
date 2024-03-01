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
    
    override init(){
        let meals = (0...20).map{ _ in Meal.placeholder }
        self.meals = meals
        self.displayedMeals = meals
    }
    
    public func fetchDessertList() async {
        do{
            let meals = try await client.fetchMeals(forCategory: .dessert)
            //Update the meals array with the meals from the API
            await MainActor.run{
                withAnimation{ self.meals = meals }
            }
        }catch{
            print(error)
        }
    }
    
    public func fetchDessertDetails(for meal: Meal) async -> Meal? {
        do{
            let detailedMeal = try await client.fetchMealDetails(for: meal.id)
            return detailedMeal
        }catch{
            print(error)
            return nil
        }
    }
    
    
    public func filterBySearch(){
        if searchText.isEmpty{
            displayedMeals = meals
        }else{
            displayedMeals = meals.filter{ $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}

struct RecipeListView: View {
    
    //Initialize our view model as a state object because we want to keep the view model alive as long as this list view is alive
    @StateObject private var viewModel = RecipeListViewModel()
    
    @State private var searchBarSize: CGSize = .zero
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .top){
                
                //List of Recipes
                List{
                    //Spacer to account for the search bar
                    Spacer()
                        .frame(height: searchBarSize.height)
                        .listSectionSeparator(.hidden)
                    //Iterate over the Recipes
                    ForEach(viewModel.displayedMeals){ meal in
                        NavigationLink(destination: { MealDetailView(meal: meal) }, label: {
                            MealCell(meal)
                        })
                        .listRowSeparatorTint(Color.lilac.opacity(0.5))
                        .foregroundColor(Color.purple)
                        .listRowBackground(Color.white1)
                    }
                }
                .listStyle(.plain)
                
                //MARK: Search Bar -
                HStack{
                    Image(systemName: "magnifyingglass")
                        .font(.headline)
                        .foregroundStyle(Color.tertiaryText)
                    
                    TextField("Find Your Favorite Dessert", text: $viewModel.searchText)
                        .headline()
                        .onChange(of: viewModel.searchText){ _ in
                            withAnimation(.bouncy){ viewModel.filterBySearch() }
                        }
                }
                .foregroundStyle(Color.primaryText)
                .padding(10)
                .background(Color.lilac.opacity(0.33))
                .background{
                    //Get the size of the search bar
                    GeometryReader{ geo2 in
                        Rectangle()
                            .fill(Material.ultraThin)
                            .preference(key: SizePreferenceKey.self, value: geo2.size)
                    }
                }
                .clipShape(Capsule())
                .padding(.top, 5)
                .padding(.horizontal)
                
            }
            .background(Color.white1)
            .onPreferenceChange(SizePreferenceKey.self) { size in
                if let size = size {
                    self.searchBarSize = size
                }
            }
            .task{
                //Fetch the list of desserts
                await viewModel.fetchDessertList()
            }
            .onChange(of: viewModel.meals){ _ in
                withAnimation(.bouncy){ viewModel.displayedMeals = viewModel.meals }
            }
        }
    }
    
    var iphone: some View {
        Text("")
    }
    
}

#Preview {
    RecipeListView()
}

struct MealDetailView: View{
    
    let meal: Meal
    @EnvironmentObject var viewModel: RecipeListViewModel
    
    var body: some View{
        VStack{
            Text(meal.name)
                .title2()
            ForEach(meal.ingredients ?? []){ ingredient in
                Text(ingredient.name)
                    .headline()
            }
            Text(meal.instructions ?? "")
        }
//        .task{
//            await viewModel.fetchDessertDetails(for: meal)
//        }
    }
    
}
