//
//  UIImage+ResizerExt.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 4/5/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import Foundation
import CoreGraphics

extension UIImage {
    func overlayed(with overlay: UIImage, canvasSize: CGSize) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        UIGraphicsBeginImageContext(canvasSize)
        self.draw(in: CGRect(origin: CGPoint.zero, size: canvasSize))
        overlay.draw(in: CGRect(origin: CGPoint.zero, size: canvasSize))
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            return image
        }
        return nil
    }
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func resizeToMaxSizeInKB(sizeInkb: Double) -> UIImage? {
        guard let imageData = UIImagePNGRepresentation(self) else { return nil }
        
        var resizingImage = self
        var imageSizekb = Double(imageData.count) / 1000.0 // [1024=KB 1000=kB]
        
        while imageSizekb > sizeInkb {
            guard let resizedImage = resizingImage.resized(withPercentage: 0.9),
                let imageData = UIImagePNGRepresentation(resizedImage)
                else { return nil }
            
            resizingImage = resizedImage
            imageSizekb = Double(imageData.count) / 1000.0 // ! Or devide for 1024 if you need KB but not kB
        }
        return resizingImage
    }
    
    
    
    
}


