//
//  ImageController.swift
//  SwiftUI_Sample_PhotoFilter
//
//  Created by cano on 2022/01/01.
//

import Foundation
import SwiftUI

class ImageController: ObservableObject {
    
    @Published var originalImage = UIImage(named: "temple") {
        didSet {
            displayedImage = originalImage
            thumbnailImage = originalImage?.compressed()
        }
    }
    
    @Published var displayedImage = UIImage(named: "temple")
    
    var thumbnailImage = UIImage(named: "temple")?.compressed()
    
    func generateFilteredImage(inputImage: UIImage, filter: FilterType) -> UIImage {
        let context = CIContext(options: nil)
        let unprocessedImage = CIImage(image: inputImage)
        
        switch filter {
        case .Original:
            return originalImage!
        case .Sepia:
            let filter = CIFilter(name: "CISepiaTone")
            filter?.setValue(unprocessedImage, forKey: "inputImage")
            
            if let output = filter?.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: cgimg)
                    return processedImage
                }
            }
        case .Mono:
            let filter = CIFilter(name: "CIPhotoEffectMono")
            filter?.setValue(unprocessedImage, forKey: "inputImage")
            
            if let output = filter?.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: cgimg)
                    return processedImage
                }
            }
        case .Vibrance:
            let filter = CIFilter(name: "CIVibrance")
            filter?.setValue(unprocessedImage, forKey: "inputImage")
            filter?.setValue(20, forKey: "inputAmount")
        
            if let output = filter?.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: cgimg)
                    return processedImage
                }
            }
        case .Highlight:
            let filter = CIFilter(name: "CIHighlightShadowAdjust")
            filter?.setValue(unprocessedImage, forKey: "inputImage")
            filter?.setValue(1.4, forKey: "inputHighlightAmount")
            filter?.setValue(3.0, forKey: "inputShadowAmount")

            if let output = filter?.outputImage {
                if let cgimg =  context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: cgimg)
                    return processedImage
                }
            }
        case .Vignette:
            let filter = CIFilter(name: "CIVignette")
            filter?.setValue(unprocessedImage, forKey: "inputImage")
            filter?.setValue(1.0, forKey: "inputRadius")
            filter?.setValue(3.0, forKey: "inputIntensity")

            if let output = filter?.outputImage {
                if let cgimg =  context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: cgimg)
                    return processedImage
                }
            }
        }
        
        return originalImage!
    }
    
    func saveImage() {
        UIImageWriteToSavedPhotosAlbum(displayedImage!, nil, nil, nil)
    }
    
}
