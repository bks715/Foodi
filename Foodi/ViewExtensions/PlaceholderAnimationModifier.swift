//
//  PlaceholderAnimationModifier.swift
//  Foodi
//
//  Created by Braden Smith on 2/29/24.
//

import SwiftUI

fileprivate struct LoadingViewViewModifier: ViewModifier {
    
    @State private var animationStartTime = Date()
    let isLoading: Bool
    let loopDuration: TimeInterval
    
    init(isLoading: Bool, loopDuration: TimeInterval){
        self.isLoading = isLoading
        self.loopDuration = loopDuration
    }
    
    func body(content: Content) -> some View {
        if isLoading{
            content
                .mask(
                    GeometryReader{ geo in
                        TimelineView(.animation){ context in
                            LinearGradient(stops: [.init(color: .white.opacity(0.33), location: 0.4), .init(color: .lilac, location: 0.5), .init(color: .white.opacity(0.33), location: 0.6)], startPoint: .bottomLeading, endPoint: .topTrailing)
                                .scaleEffect(3)
                                .offset(x: animationOffset(width: geo.size.width), y: -animationOffset(width: geo.size.height))
                        }
                    }
                )
        }else{
            content
        }
    }
    
    
    func animationOffset(width: CGFloat) -> CGFloat{
        let time = Date().timeIntervalSince(animationStartTime)
        let percentage = CGFloat(fmod(time, loopDuration)/loopDuration)*1.5
        return (percentage-0.7)*width
    }
    
}

extension View{
    
    /// Apply a placeholder animation to the view
    /// - Parameters:
    ///  - isLoading: Whether or not the view is loading
    ///  - loopDuration: The duration of the animation loop
    ///  - Returns: A view with a placeholder animation
    func placeholderAnimation(isLoading: Bool, loopDuration: TimeInterval = 1.0) -> some View{
        self.modifier(LoadingViewViewModifier(isLoading: isLoading, loopDuration: loopDuration))
    }
    
}

#Preview{
    RecipeListView()
}
