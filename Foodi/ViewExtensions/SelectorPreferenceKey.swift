//
//  SelectionPreferenceKey.swift
//  Foodi
//
//  Created by Braden Smith on 3/5/24.
//

import SwiftUI

/// `SelectorPreferenceKey` serves as a custom preference key to store a dictionary
/// mapping identifiers to their corresponding `Anchor<CGRect>` values.
struct SelectorPreferenceKey: PreferenceKey {
    
    /// The default value for the preference key.
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    
    /// Combines the current value with the next value, preferring the next value
    /// when duplicate keys are encountered.
    /// - Parameters:
    ///   - value: The current value of the preference key.
    ///   - nextValue: A closure that returns the next value to be combined.
    static func reduce(value: inout [String: Anchor<CGRect>], nextValue: () -> [String: Anchor<CGRect>]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
    
}
