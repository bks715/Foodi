//
//  SegmenterImageModifier.swift
//  Foodi
//
//  Created by Braden Smith on 3/5/24.
//

import SwiftUI
import Kingfisher
import Vision
import VideoToolbox

///Image Modifier that uses Vision to segment the image and return only the subject or foreground of an image
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
        
        //Turn the image into a CIImage and return the image normally if it fails
        guard let cgImage = image.cgImage else { return image }
        let ciImage = CIImage(cgImage: cgImage)
        let handler = VNImageRequestHandler(ciImage: ciImage)
        let request = VNGenerateForegroundInstanceMaskRequest()
        //Segment the image using Vision's Generate Foreground Instance Mask Request
        do {
            try handler.perform([request])
            
            guard let result = request.results?.first else { return image }
            //Segment the Image with the return Masked CVPixelBuffer
            let segmentationBuffer = try result.generateMaskedImage(ofInstances: result.allInstances, from: handler, croppedToInstancesExtent: true)
            //Create a Pointer for cgImage and create the cgImage from the segmentation mask CVPixelBuffer
            var cgImage: CGImage?
                VTCreateCGImageFromCVPixelBuffer(segmentationBuffer, options: nil, imageOut: &cgImage)
            //Make sure the cgImage was created and return the new image
            guard let cgImage else { return image }
            return KFCrossPlatformImage(cgImage: cgImage)
        } catch {
            //As this error isn't detrimental to the app, just print it and return the original image
            print(error)
            return image
        }
    }
    
}
