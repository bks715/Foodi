//
//  Meal.swift
//  Foodi
//
//  Created by Braden Smith on 2/29/24.
//

import Foundation

public struct Meal: Hashable, Identifiable {
    
    //MARK: Properties -
    //Immutable Properties that are required to be initialized at the time of creation -
    /// The unique identifier for the meal.
    public let id: Int
    /// The name of the meal (e.g. "Apple Frangipan Tart").
    public let name: String
    
    //Mutable Properties -
    /// The category of the meal (e.g. "Dessert").
    public var category: String?
    /// The area or region the meal originates from (e.g. "British" or "Italian").
    public var area: String?
    /// The instructions for preparing the meal. - Optional
    public var instructions: String?
    /// An optional URL for the thumbnail image of the meal. - Optional
    public var thumbnailURL: String?
    /// An optional array of  tags (Strings) associated with the meal (e.g. "Tart", "Baking", "Fruity").
    public var tags: [String]?
    /// An optional URL for a YouTube video showing how to prepare the meal.
    public var youtubeURL: String?
    /// An optional URL for the source of the meal (e.g. "https://www.bbcgoodfood.com/recipes/apple-frangipan-tart").
    public var sourceURL: String?
    /// An optional array of ingredients required to prepare the meal.
    public var ingredients: [Ingredient]?
    
    //MARK: Computed Properties -
    /// A computed property that returns a boolean value indicating whether the meal is a placeholder.
    public var isPlaceHolder: Bool {
        return name == "Placeholder"
    }
    
    ///String used to search for the meal including it's name, tags, and ingredient names
    public var searchQuery: String {
        var query = name
        if let tags = tags {
            query += " " + tags.joined(separator: " ")
        }
        if let ingredients = ingredients {
            query += " " + ingredients.map({ $0.name }).joined(separator: " ")
        }
        return query
    }
    
    public var isFavorite: Bool {
        get{
            return UserDefaults.standard.bool(forKey: "\(id)")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "\(id)")
        }
    }
    
    //MARK: Initializers -
    /// A custom initializer for creating a `Meal` model with or without optional properties.
    /// - Parameters:
    /// - id: The unique identifier for the meal.
    /// - name: The name of the meal.
    /// - category: The category of the meal.
    /// - area: The area or region the meal originates from.
    /// - instructions: The instructions for preparing the meal.
    /// - thumbnailURL: The URL for the thumbnail image of the meal.
    /// - tags: An array of tags associated with the meal.
    /// - youtubeURL: The URL for a YouTube video showing how to prepare the meal.
    /// - sourceURL: The URL for the source of the meal.
    /// - ingredients: An array of ingredients required to prepare the meal.
    public init(id: Int, name: String, category: String? = nil, area: String? = nil, instructions: String? = nil, thumbnailURL: String? = nil, tags: [String]? = nil, youtubeURL: String? = nil, sourceURL: String? = nil, ingredients: [Ingredient]? = nil) {
        self.id = id
        self.name = name
        self.category = category
        self.area = area
        self.instructions = instructions
        self.thumbnailURL = thumbnailURL
        self.tags = tags
        self.youtubeURL = youtubeURL
        self.sourceURL = sourceURL
        self.ingredients = ingredients
    }
}
    
    //MARK: Codable Implementation -
    
extension Meal: Codable {
    
    //Coding Keys - Enum that conforms to CodingKey Protocol
    //Needed to map the properties of the Meal model to the keys in the JSON data.
    private enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case thumbnailURL = "strMealThumb"
        case tags = "strTags"
        case youtubeURL = "strYoutube"
        case sourceURL = "strSource"
        //Unfortunately the API doesn't return an array of ingredients but rather a key for up to 20 ingredient names and 20 ingredient unit values so we will need keys for each of those.
        case ingredientName1 = "strIngredient1"
        case ingredientName2 = "strIngredient2"
        case ingredientName3 = "strIngredient3"
        case ingredientName4 = "strIngredient4"
        case ingredientName5 = "strIngredient5"
        case ingredientName6 = "strIngredient6"
        case ingredientName7 = "strIngredient7"
        case ingredientName8 = "strIngredient8"
        case ingredientName9 = "strIngredient9"
        case ingredientName10 = "strIngredient10"
        case ingredientName11 = "strIngredient11"
        case ingredientName12 = "strIngredient12"
        case ingredientName13 = "strIngredient13"
        case ingredientName14 = "strIngredient14"
        case ingredientName15 = "strIngredient15"
        case ingredientName16 = "strIngredient16"
        case ingredientName17 = "strIngredient17"
        case ingredientName18 = "strIngredient18"
        case ingredientName19 = "strIngredient19"
        case ingredientName20 = "strIngredient20"
        //Ingredient Units
        case ingredientUnit1 = "strMeasure1"
        case ingredientUnit2 = "strMeasure2"
        case ingredientUnit3 = "strMeasure3"
        case ingredientUnit4 = "strMeasure4"
        case ingredientUnit5 = "strMeasure5"
        case ingredientUnit6 = "strMeasure6"
        case ingredientUnit7 = "strMeasure7"
        case ingredientUnit8 = "strMeasure8"
        case ingredientUnit9 = "strMeasure9"
        case ingredientUnit10 = "strMeasure10"
        case ingredientUnit11 = "strMeasure11"
        case ingredientUnit12 = "strMeasure12"
        case ingredientUnit13 = "strMeasure13"
        case ingredientUnit14 = "strMeasure14"
        case ingredientUnit15 = "strMeasure15"
        case ingredientUnit16 = "strMeasure16"
        case ingredientUnit17 = "strMeasure17"
        case ingredientUnit18 = "strMeasure18"
        case ingredientUnit19 = "strMeasure19"
        case ingredientUnit20 = "strMeasure20"
    }
    
    
    //Custom Initializer to decode the JSON data into the Meal model
    /// A custom initializer for creating a `Meal` model from JSON data recived from the MealsDB API.
    public init(from decoder: any Decoder) throws {
        //Create a container to hold the keys and values from the JSON data
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        //Decode the values for the required properties
        
        //The id value is a string in the JSON data so we need to decode it as a string and then convert it to an integer.
        let idString = try container.decode(String.self, forKey: .id)
        guard let id = Int(idString) else {
            throw DecodingError.dataCorruptedError(forKey: .id, in: container, debugDescription: "Invalid ID value")
        }
        
        self.id = id
        self.name = try container.decode(String.self, forKey: .name)
        
        //Decode the optional values for the remaining properties
        self.category = try container.decodeIfPresent(String.self, forKey: .category)
        self.area = try container.decodeIfPresent(String.self, forKey: .area)
        self.instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
        self.thumbnailURL = try container.decodeIfPresent(String.self, forKey: .thumbnailURL)
        
        //The tags are an optional value returned as a comma separated string so we need to decode it as a string then split it into an array
        if let tagString = try container.decodeIfPresent(String.self, forKey: .tags){
            self.tags = tagString.components(separatedBy: ",")
        }
        
        self.youtubeURL = try container.decodeIfPresent(String.self, forKey: .youtubeURL)
        self.sourceURL = try container.decodeIfPresent(String.self, forKey: .sourceURL)
        
        //Decode the ingredients - The API returns up to 20 ingredient names and 20 ingredient unit values so we need to decode each of those
        //We will use a sequence of numbers to loop through the keys and decode the name and measurement for each ingredient if it exists.
        //We use compactMap to filter out nil values and returning an array of Ingredient objects.
        var ingredients = Set<Ingredient>()
        try (1...20).forEach { number in
            //Get the coding key for the ingredient name and measurement
            guard let ingredientNameKey = CodingKeys(rawValue: "strIngredient\(number)"),
                  let ingredientMeasurementKey = CodingKeys(rawValue: "strMeasure\(number)") else { return }
            
            //Return the decoded value for ingredientName if it exists
            let ingredientName = try container.decodeIfPresent(String.self, forKey: ingredientNameKey)
            //Return the decoded value for ingredientMeasurement if it exists
            let ingredientMeasurement = try container.decodeIfPresent(String.self, forKey: ingredientMeasurementKey)
            
            //Ensure that the ingredient name and measurement are not nil
            guard let ingredientName, let ingredientMeasurement else { return }
            //Ensure that the ingredient name and measurement are not empty
            guard !ingredientName.isEmpty, !ingredientMeasurement.isEmpty else { return }
            
            ingredients.insert(Ingredient(name: ingredientName, measurement: ingredientMeasurement))
        }
        
        //Set the ingredients property to the array of Ingredient objects
        self.ingredients = ingredients.sorted(by: { $0.name < $1.name })
    }
    
    //Encode the Meal model to JSON data
    //Although we don't expect to send the Meal model to a server, we will implement the encode method for completeness.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        //Encode the values for the required properties
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        
        //Encode the optional values for the remaining properties
        try container.encodeIfPresent(category, forKey: .category)
        try container.encodeIfPresent(area, forKey: .area)
        try container.encodeIfPresent(instructions, forKey: .instructions)
        try container.encodeIfPresent(thumbnailURL, forKey: .thumbnailURL)
        try container.encodeIfPresent(tags, forKey: .tags)
        try container.encodeIfPresent(youtubeURL, forKey: .youtubeURL)
        try container.encodeIfPresent(sourceURL, forKey: .sourceURL)
        
        //Encode the ingredients if they exist
        //Use a guard let to unwrap the optional ingredients property if it exists
        guard let ingredients = self.ingredients else { return }
        
        //Iterate through the ingredients array and encode each Ingredient Name and Measurement Value
        for (index, ingredient) in ingredients.enumerated() {
            //Ensure that we only encode up to 20 ingredients
            guard index < 20 else { break }
            
            //Get the coding key for the ingredient name and measurement
            guard let ingredientNameKey = CodingKeys(rawValue: "strIngredient\(index + 1)"),
                  let ingredientMeasurementKey = CodingKeys(rawValue: "strMeasure\(index + 1)") else { continue }
            
            //Encode the ingredient name and measurement
            try container.encode(ingredient.name, forKey: ingredientNameKey)
            try container.encode(ingredient.measurement, forKey: ingredientMeasurementKey)
        }
    }
    
}

//MARK: - Meal Placeholder
extension Meal {
    public static let placeholder = Meal(id: 5071998, name: "Placeholder")
    
    public static let mockMeal = Meal(id: 52768, name: "Apple Frangipan Tart", category: "Dessert", area: "British", instructions: "Preheat the oven to 200C/180C Fan/Gas 6.\r\nPut the biscuits in a large re-sealable freezer bag and bash with a rolling pin into fine crumbs. Melt the butter in a small pan, then add the biscuit crumbs and stir until coated with butter. Tip into the tart tin and, using the back of a spoon, press over the base and sides of the tin to give an even layer. Chill in the fridge while you make the filling.\r\nCream together the butter and sugar until light and fluffy. You can do this in a food processor if you have one. Process for 2-3 minutes. Mix in the eggs, then add the ground almonds and almond extract and blend until well combined.\r\nPeel the apples, and cut thin slices of apple. Do this at the last minute to prevent the apple going brown. Arrange the slices over the biscuit base. Spread the frangipane filling evenly on top. Level the surface and sprinkle with the flaked almonds.\r\nBake for 20-25 minutes until golden-brown and set.\r\nRemove from the oven and leave to cool for 15 minutes. Remove the sides of the tin. An easy way to do this is to stand the tin on a can of beans and push down gently on the edges of the tin.\r\nTransfer the tart, with the tin base attached, to a serving plate. Serve warm with cream, crème fraiche or ice cream.", thumbnailURL: "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg", tags: ["Tart","Baking","Fruity"], youtubeURL: "https://www.youtube.com/watch?v=rp8Slv4INLk", sourceURL: nil, ingredients: [Ingredient(name: "digestive biscuits", measurement: "175g/6oz"),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            Ingredient(name: "butter", measurement: "75g/3oz"),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  Ingredient(name: "Bramley apples", measurement: "200g/7oz"),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  Ingredient(name: "butter, softened", measurement: "75g/3oz"),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  Ingredient(name: "caster sugar", measurement: "75g/3oz"),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  Ingredient(name: "free-range eggs, beaten", measurement: "2"),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  Ingredient(name: "ground almonds", measurement: "75g/3oz"),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  Ingredient(name: "almond extract", measurement: "1 tsp"),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  Ingredient(name: "flaked almonds", measurement: "50g/1¾oz")])
}
