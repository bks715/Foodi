//
//  SlidingPickerView.swift
//  Foodi
//
//  Created by Braden Smith on 3/5/24.
//

import SwiftUI

/// A custom sliding picker view component for SwiftUI.
///
/// This view creates a horizontal selection of buttons based on the provided `values`.
/// The currently selected value is highlighted and can be changed by tapping on a different button.
/// The selection is bound to a state variable that can be used to react to changes.
struct SlidingPickerView: View {
    
    /// The currently selected value, bound to a state variable.
    @Binding var selection: String
    /// An array of strings representing the possible values to choose from.
    let values: [String]
    
    var body: some View {
        HStack{
            ForEach(values, id: \.self){ value in
                Button(value.capitalized, action: { withAnimation(.bouncy){ selection = value} })
                    .anchorPreference(key: SelectorPreferenceKey.self, value: .bounds, transform: { anchor in
                        return [value:anchor]
                    })
            }
        }
        .font(.dmSans(size: 15, style: .subheadline, weight: .medium))
        .foregroundColor(.primaryText)
        .overlayPreferenceValue(SelectorPreferenceKey.self) { preferences in
            GeometryReader{ geo in
                if let anchor = preferences[self.selection] {
                    let rect = geo[anchor]
                    RoundedRectangle(cornerRadius: 1)
                        .fill(Color.lilac)
                        .frame(width: rect.width, height: 3)
                        .position(x: rect.midX, y: rect.maxY+5)
                        
                }
            }
        }
    }
}

#Preview {
    SlidingPickerView(selection: .constant("turtle"), values: ["turtle", "frog", "lizard"])
}
