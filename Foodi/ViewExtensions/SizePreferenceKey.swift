//
//  SizePreferenceKey.swift
//  Foodi
//
//  Created by Braden Smith on 3/1/24.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize? = nil
    static func reduce(value: inout CGSize?, nextValue: () -> CGSize?) {
        value = value ?? nextValue()
    }
}
