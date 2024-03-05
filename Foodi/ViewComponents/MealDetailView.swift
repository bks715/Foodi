//
//  MealDetailView.swift
//  Foodi
//
//  Created by Braden Smith on 3/1/24.
//

import SwiftUI
import Kingfisher
import Vision
import VideoToolbox

struct SegmentationImageModifier: ImageModifier {
    
    
    
    func modify(_ image: Kingfisher.KFCrossPlatformImage) -> Kingfisher.KFCrossPlatformImage {
        if #available(iOS 17.0, *){
            return segmentImage(image)
        }else{
            return image
        }
    }
    
    @available(iOS 17.0, *)
    func segmentImage(_ image: Kingfisher.KFCrossPlatformImage) -> Kingfisher.KFCrossPlatformImage {
        
        guard let cgImage = image.cgImage else { print("Couldn't get cgimage") ; return image }
        let ciImage = CIImage(cgImage: cgImage)
        let handler = VNImageRequestHandler(ciImage: ciImage)
        let request = VNGenerateForegroundInstanceMaskRequest()
        
        do {
            try handler.perform([request])
            
            guard let result = request.results?.first else { return image }
            let segmentationBuffer = try result.generateMaskedImage(ofInstances: result.allInstances, from: handler, croppedToInstancesExtent: true)
            var cgImage: CGImage?
                VTCreateCGImageFromCVPixelBuffer(segmentationBuffer, options: nil, imageOut: &cgImage)
            guard let cgImage else { return image }
            return KFCrossPlatformImage(cgImage: cgImage)
        } catch {
            print(error)
            return image
        }
    }
    
}


struct MealDetailView: View{
    
    //Binded Meal that contains the information for the view
    @Binding var meal: Meal
    //Horizontal Size Class
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View{
        GeometryReader{ geo in
            
            ZStack(alignment: .top) {
                
                if let imgURL = meal.thumbnailURL{
                    ZStack{
                        KFImage(URL(string: imgURL))
                            .resizable()
                            .placeholder({ prog in
                                Color.lilac
                                    .overlay{
                                        ProgressView()
                                            .tint(Color(hex: "F6E8AC"))
                                    }
                            })
                            .scaledToFill()
                            .frame(width: geo.size.width)
                        
                        KFImage(URL(string: imgURL))
                            .resizable()
                            .placeholder({ prog in
                                Color.lilac
                                    .overlay{
                                        ProgressView()
                                            .tint(Color(hex: "F6E8AC"))
                                    }
                            })
                            .imageModifier(SegmentationImageModifier())
                            .scaledToFill()
                            .frame(width: geo.size.width, height: geo.size.height * (sizeClass == .regular ? 0.4 : 0.3))
                            .background{
                                Rectangle()
                                    .fill(Material.ultraThin)
                                    .frame(width: geo.size.width, height: geo.size.height)
                                    .ignoresSafeArea()
                            }
                            .shadow(radius: 5)
                    }
                    .frame(height: geo.size.height * (sizeClass == .regular ? 0.45 : 0.35))
                }else{
                    Color.lilac
                        .opacity(0.5)
                        .frame(width: 44, height: 44)
                        .cornerRadius(8)
                        .shadow(color: .black.opacity(0.12), radius: 6, x: 3, y: 5)
                }
                
                ScrollView(.vertical) {
                    VStack(spacing: 0){
                        
                        Spacer()
                            .frame(height: geo.size.height * (sizeClass == .regular ? 0.4 : 0.3) - 20)
                        
                        VStack(spacing: 15){
                            Text(meal.name)
                                .foregroundStyle(Color.primaryText)
                                .font(.dmSans(size: 24, style: .title, weight: .bold))
                            
                            VStack(spacing: 10){
                                ForEach(meal.ingredients ?? []){ ingredient in
                                    Text(ingredient.name)
                                        .headline()
                                }
                            }
                            
                            Text(meal.instructions ?? "")
                                .body()
                            
                            Spacer()
                        }
                        .padding()
                        .background(Material.ultraThin)
                        .cornerRadius(10, corners: [.topLeft, .topRight])
                        .shadow(radius: 5, y: -1)
                        
                    }
                    
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
    }
    
}

#Preview {
    MealDetailView(meal: .constant(.mockMeal))
}
