//
//  SearchBar.swift
//  Foodi
//
//  Created by Braden Smith on 3/1/24.
//

import SwiftUI

struct SearchBar: View {
    
    ///The text that is being searched for
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        //MARK: Search Bar -
        HStack{
            Image(systemName: "magnifyingglass")
                .font(.headline)
                .foregroundStyle(Color.tertiaryText)
                .onTapGesture {
                    //Incase the user taps the search icon, focus the search bar
                    withAnimation(.bouncy){
                        isFocused = true
                    }
                }
            
            TextField("Find Your Favorite Dessert", text: $text)
                .headline()
                .focused($isFocused)
                
            
            //A Button that makes it easy to clear the search text
            if !text.isEmpty{
                Button(action: {
                    withAnimation(.bouncy){ text = "" }
                }, label: {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .foregroundStyle(Color.tertiaryText)
                })
            }
        }
        .foregroundStyle(Color.primaryText)
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
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
        .shadow(color: .black.opacity(0.12), radius: 6, x: 3, y: 5)
        
    }
}

#Preview {
    SearchBar(text: .constant("Hello"))
}
