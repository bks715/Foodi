//
//  FontExtensions.swift
//  AppsmithsEssentials
//
//  Created by Braden Smith on 4/8/23.
//

import Foundation
import SwiftUI
import CoreText

//Font Extension brought over from my custom AppsmithsEssentails Package
//The package is private so I thought it would be best to include the extension here for the DMSans font instead of using the package through SPM. 
extension Font {
    
    public static func dmSans(size: CGFloat, style: Font.TextStyle, weight: Weight) -> Font {
        
        switch weight{
        case .medium, .semibold:
            return Font.custom("DMSans-Medium", size: size, relativeTo: style)
        case .heavy, .black, .bold:
            return Font.custom("DMSans-Bold", size: size, relativeTo: style)
        default:
            return Font.custom("DMSans-Regular", size: size, relativeTo: style)
        }
        
    }
    
    public static var dmTitle2: Font {
        return dmSans(size: 21, style: .title2, weight: .medium)
    }
    
    public static var dmTitle3: Font {
        return dmSans(size: 19, style: .title3, weight: .medium)
    }
    
    public static var dmHeadline: Font {
        return dmSans(size: 17, style: .headline, weight: .medium)
    }
    
    public static var dmBody: Font {
        return dmSans(size: 17, style: .body, weight: .regular)
    }
    
    public static var dmSubtitle: Font {
        return dmSans(size: 15, style: .subheadline, weight: .medium)
    }
    
    public static var dmCallout: Font {
        return dmSans(size: 15, style: .callout, weight: .regular)
    }
    
    public static var dmFootnote: Font {
        return dmSans(size: 13, style: .footnote, weight: .medium)
    }
    
    public static var dmFootnote2: Font {
        return dmSans(size: 13, style: .footnote, weight: .regular)
    }
    
    public static var dmCaption: Font {
        return dmSans(size: 12, style: .caption, weight: .regular)
    }
    
    public static var dmCaptionB: Font {
        return dmSans(size: 12, style: .caption, weight: .bold)
    }
    
}

#if os(iOS)

@available(iOS 15.0, *)
extension UIFont {
        
        public static func dmSans(size: CGFloat, weight: Weight) -> UIFont {
            
            switch weight{
            case .medium, .semibold:
                return UIFont(name: "DMSans-Medium", size: size)!
            case .heavy, .black, .bold:
                return UIFont(name: "DMSans-Bold", size: size)!
            default:
                return UIFont(name: "DMSans-Regular", size: size)!
            }
            
        }
        
        public static var dmTitle2: UIFont {
            return dmSans(size: 21, weight: .medium)
        }
    
    public static var dmTitle3: UIFont {
            return dmSans(size: 20, weight: .medium)
        }
        
    public static var dmHeadline: UIFont {
            return dmSans(size: 17, weight: .medium)
        }
        
    public static var dmBody: UIFont {
            return dmSans(size: 17, weight: .regular)
        }
        
    public static var dmSubtitle: UIFont {
            return dmSans(size: 15, weight: .medium)
        }
        
    public static var dmCallout: UIFont {
            return dmSans(size: 15, weight: .regular)
        }
        
    public static var dmFootnote: UIFont {
            return dmSans(size: 13, weight: .medium)
        }
        
    public static var dmFootnote2: UIFont {
            return dmSans(size: 13, weight: .regular)
        }
        
    public static var dmCaption: UIFont {
            return dmSans(size: 12, weight: .regular)
        }
        
    public static var dmCaptionB: UIFont {
            return dmSans(size: 12, weight: .bold)
        }
        
}

#elseif os(macOS)

@available(macOS 13.0, *)
extension NSFont {
        
        public static func dmSans(size: CGFloat, weight: Weight) -> NSFont {
            
            switch weight{
            case .medium, .semibold:
                return NSFont(name: "DMSans-Medium", size: size)!
            case .heavy, .black, .bold:
                return NSFont(name: "DMSans-Bold", size: size)!
            default:
                return NSFont(name: "DMSans-Regular", size: size)!
            }
            
        }
        
        public static var dmTitle2: NSFont {
            return dmSans(size: 21, weight: .medium)
        }
    
    public static var dmTitle3: NSFont {
            return dmSans(size: 20, weight: .medium)
        }
        
    public static var dmHeadline: NSFont {
            return dmSans(size: 17, weight: .medium)
        }
        
    public static var dmBody: NSFont {
            return dmSans(size: 17, weight: .regular)
        }
        
    public static var dmSubtitle: NSFont {
            return dmSans(size: 15, weight: .medium)
        }
        
    public static var dmCallout: NSFont {
            return dmSans(size: 15, weight: .regular)
        }
        
    public static var dmFootnote: NSFont {
            return dmSans(size: 13, weight: .medium)
        }
        
    public static var dmFootnote2: NSFont {
            return dmSans(size: 13, weight: .regular)
        }
        
    public static var dmCaption: NSFont {
            return dmSans(size: 12, weight: .regular)
        }
        
    public static var dmCaptionB: NSFont {
            return dmSans(size: 12, weight: .bold)
        }
        
}


#endif


@available(iOS 15.0, macOS 10.15.0, *)
extension View {
    
    public func title2()-> some View {
        self.modifier(DMSans(size: 21, style: .title2, weight: .medium))
    }
    
    public func title3()-> some View {
        self.modifier(DMSans(size: 20, style: .title3, weight: .medium))
    }
    
    public func headline()-> some View {
        self.modifier(DMSans(size: 17, style: .headline, weight: .medium))
    }
    
    public func body()-> some View {
        self.modifier(DMSans(size: 17, style: .body, weight: .regular))
    }
    
    public func subtitle()-> some View {
        self.modifier(DMSans(size: 15, style: .subheadline, weight: .medium))
    }
    
    public func callout()-> some View {
        self.modifier(DMSans(size: 15, style: .callout, weight: .regular))
    }
    
    public func footnote()-> some View {
        self.modifier(DMSans(size: 13, style: .footnote, weight: .medium))
    }
    
    public func footnote2()-> some View {
        self.modifier(DMSans(size: 13, style: .footnote, weight: .regular))
    }
    
    public func caption()-> some View {
        self.modifier(DMSans(size: 12, style: .caption, weight: .regular))
    }
    
    public func captionB()-> some View {
        self.modifier(DMSans(size: 12, style: .caption, weight: .bold))
    }
    
}

//create a modifier for the dmSans font
@available(iOS 15.0, macOS 10.15.0, *)
public struct DMSans: ViewModifier {
    
    public var size: CGFloat
    public var style: Font.TextStyle
    public var weight: Font.Weight
    
    //create init
    public init(size: CGFloat, style: Font.TextStyle, weight: Font.Weight) {
        self.size = size
        self.style = style
        self.weight = weight
    }
    
    
    public func body(content: Content) -> some View {
        content.font(.dmSans(size: size, style: style, weight: weight))
    }
    
}

