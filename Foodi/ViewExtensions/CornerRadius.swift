//
//  CornerRadius.swift
//  AppsmithsEssentials
//
//  Created by Braden Smith on 9/8/23.
//

import SwiftUI

public struct CustomCorner: Shape {
    
    public var radius: CGFloat
    public var corners: UIRectCorner
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

public extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(CustomCorner(radius: radius, corners: corners))
            .ignoresSafeArea( .all)
    }
}
