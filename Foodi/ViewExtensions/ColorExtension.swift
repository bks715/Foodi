//
//  ColorExtensions.swift
//  AppsmithsEssentials
//
//  Created by Braden Smith on 4/8/23.
//

import SwiftUI

extension Color {
    
    public init(hex: String) {
//        Remove the # if necessary
        var hex = hex
        hex.removeAll(where: {$0 == "#"})
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex

        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0x00ff00) >> 8
        let b = rgbValue & 0x0000ff

        self.init(
            .sRGB,
            red: Double(r) / 0xff,
            green: Double(g) / 0xff,
            blue: Double(b) / 0xff,
            opacity: 1
        )
    }
    
    //MARK: Functions -
    
    //make function that converts Color to hexcode
    public func toHexCode() -> String {
        let components = self.cgColor!.components!
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])

        let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0

        return String(format: "#%06x", rgb)
    }
    
    
}
