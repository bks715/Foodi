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
                    TimelineView(.animation){ context in
                        LinearGradient(stops: [.init(color: .white, location: animationPercentage(-0.4)), .init(color: .clear, location: animationPercentage(-0.1)), .init(color: .white, location: animationPercentage(0.1))], startPoint: .bottomLeading, endPoint: .topTrailing)
                    }
                )
        }else{
            content
        }
    }
    
    ///Get the percentage of the animation loop that has been completed by taking the current time and dividing it by the loop duration
    func animationPercentage(_ percentOffset: CGFloat = 0.0) -> CGFloat {
        let time = Date().timeIntervalSince(animationStartTime)
        let percentage = CGFloat(fmod(time, loopDuration)/loopDuration)*1.5
        
        let offsetPercentage = percentage + percentOffset
        //Rap the overflow
        return offsetPercentage
    }
    
}

extension View{
    func placeholderAnimation(isLoading: Bool, loopDuration: TimeInterval = 1.0) -> some View{
        self.modifier(LoadingViewViewModifier(isLoading: isLoading, loopDuration: loopDuration))
    }
}
