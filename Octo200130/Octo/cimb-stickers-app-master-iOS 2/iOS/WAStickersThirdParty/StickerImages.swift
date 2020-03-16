//
//  StickerImages.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 4/3/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import Foundation

// this sticker Manager can save to documentDirectory & resizeImage
class StickerDownloadManager {
    static func saveImageToDocumentDirectory(image: UIImage, name: String = "default.png" ) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = name // name of the image to be saved
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if let data = UIImagePNGRepresentation(image),!FileManager.default.fileExists(atPath: fileURL.path){
            do {
                try data.write(to: fileURL)
                print("file saved", name)
            } catch {
                print("error saving file:", error)
            }
        }
    }
    
    static func loadImageFromDocumentDirectory(nameOfImage : String) -> UIImage {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath = paths.first{
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(nameOfImage)
            let image    = UIImage(contentsOfFile: imageURL.path)
            return image!
        }
        return UIImage.init(named: "default.png")!
    }
    
    
    static func proResizer(imageToResize: UIImage, withSize size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        imageToResize.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
}

