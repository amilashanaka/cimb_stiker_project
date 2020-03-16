//
// Copyright (c) WhatsApp Inc. and its affiliates.
// All rights reserved.
//
// This source code is licensed under the BSD-style license found in the
// LICENSE file in the root directory of this source tree.
//

import UIKit
import SDWebImage

extension Dictionary {
    func bytesSize() -> Int {
        let data: NSMutableData = NSMutableData()
        let encoder: NSKeyedArchiver = NSKeyedArchiver(forWritingWith: data)
        encoder.encode(self, forKey: "dictionary")
        encoder.finishEncoding()

        return data.length
    }
}

class StickerPackManager {
    static let queue: DispatchQueue = DispatchQueue(label: "stickerPackQueue")

    static func stickersJSON(contentsOfFile filename: String) throws -> [String: Any] {
        
        if let path = Bundle.main.path(forResource: filename, ofType: "wasticker") {
            let data: Data = try Data(contentsOf: URL(fileURLWithPath: path), options: Data.ReadingOptions.alwaysMapped)
            return try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        }
        
        getStickers(stickersCompletionHandler: {stickers, error in
        })
        
        throw StickerPackError.fileNotFound
    }
    
    static func getStickers(stickersCompletionHandler: @escaping ([String: Any], Error?) -> Void) {
        let url = URL(string: HTTP.GET_ALL_STICKERS)
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!, completionHandler: {data, response, error in
            guard let data = data else { return }
            
            do {
              let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
              stickersCompletionHandler(json, nil)
                
            } catch {
              // do later
            }
        })
        
        task.resume()
    }

    
    
    static func getLatestStickers(stickersCompletionHandler: @escaping ([String: Any], Error?) -> Void) {
        let url = URL(string: HTTP.STICKERS_GIF)
          let session = URLSession.shared
          
          let task = session.dataTask(with: url!, completionHandler: {data, response, error in
              guard let data = data else { return }
              
              do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                stickersCompletionHandler(json, nil)
                  
              } catch {
                // do later
              }
          })
          
          task.resume()
      }
    
    /**
     *  Retrieves sticker packs from a JSON dictionary.
     *  If the processing of a certain sticker pack encounters an exception (see methods in StickerPack.swift),
     *  that sticker pack won't be returned along with the rest (eg if identifer isn't unique or stickers have
     *  invalid image dimensions)
     *
     *  - Parameter dict: JSON dictionary
     *  - Parameter completionHandler: called on the main queue
     */
    
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    static func run(after seconds: Int, completion: @escaping () -> Void) {
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
    }
    
    static func fetchStickerPacks(fromJSON dict: [String: Any], completionHandler: @escaping ([StickerPack]) -> Void) {
        let packs: [[String: Any]] = dict["sticker_packs"] as! [[String: Any]]
        
        for pack in packs {
            let stickers: [[String: Any]] = pack["stickers"] as! [[String: Any]]
            let trayImageFileName: String = pack["tray_image_file"] as! String
            
            for sticker in stickers {
                let filename = sticker["image_file"] as! String
                let imageUrl = sticker["image_url"] as! String
                
                let urlSticker = URL(string: "\(HTTP.API_STORAGE)\(imageUrl)")
                getData(from: urlSticker!) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    let imageData = ImageData(data: data, type: ImageDataExtension.webp)
                    let webPData = imageData.webpData
                    
                        DispatchQueue.main.async {
                            let imgURL = FileManager.documentDirectoryURL.appendingPathComponent(filename).appendingPathExtension("webp")
                            
                            try! webPData!.write(to: imgURL)
                        }
                    }

        }
            
            // Download Trays
            let url = URL(string: "\(HTTP.API_STORAGE)\(trayImageFileName)")
            getData(from: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            let fileName = url!.deletingPathExtension().lastPathComponent
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                let compressedImage = image?.resizeToMaxSizeInKB(sizeInkb: 50)
                let scaledImage = compressedImage?.resizeImage(targetSize: CGSize(width: 96, height: 96))
                let imgURL = FileManager.documentDirectoryURL.appendingPathComponent(fileName+".png")
                let imgData = UIImagePNGRepresentation(scaledImage!)
                try! imgData!.write(to: imgURL)

//                let heightInPoints = scaledImage!.size.height
//                let heightInPixels = heightInPoints * scaledImage!.scale
//
//                let widthInPoints = scaledImage!.size.width
//                let widthInPixels = widthInPoints * scaledImage!.scale
                
//                print("OriginalSize:", heightInPixels, widthInPixels)
//                print("ScaledSize:", scaledImage!)
                }
            }
        
        }
       
            run(after: 3, completion: {
                queue.async {
                    let packs: [[String: Any]] = dict["sticker_packs"] as! [[String: Any]]
                    var stickerPacks: [StickerPack] = []
                    var currentIdentifiers: [String: Bool] = [:]
                    
                    let iosAppStoreLink: String? = dict["ios_app_store_link"] as? String
                    let androidAppStoreLink: String? = dict["android_play_store_link"] as? String
                    Interoperability.iOSAppStoreLink = iosAppStoreLink != "" ? iosAppStoreLink : nil
                    Interoperability.AndroidStoreLink = androidAppStoreLink != "" ? androidAppStoreLink : nil
                    
                    for pack in packs {
                        let packName: String = pack["name"] as! String
                        let packPublisher: String = pack["publisher"] as! String
                        let packTrayNameRaw: String = pack["tray_image_file"] as! String
                        
                        let packTrayImageFileName = packTrayNameRaw.contains("jpg") ? packTrayNameRaw.replacingOccurrences(of: "jpg", with: "png") : packTrayNameRaw
                        
                        let packPublisherWebsite: String? = pack["publisher_website"] as? String ?? nil
                        let packPrivacyPolicyWebsite: String? = pack["privacy_policy_website"] as? String ?? nil
                        let packLicenseAgreementWebsite: String? = pack["license_agreement_website"] as? String ?? nil
                        
                        // Pack identifier has to be a valid string and be unique
                        let packIdentifier: String? = pack["identifier"] as? String
                        if packIdentifier != nil && currentIdentifiers[packIdentifier!] == nil {
                            currentIdentifiers[packIdentifier!] = true
                        } else {
                            if let packIdentifier = packIdentifier {
                                fatalError("Missing identifier or a sticker pack already has the identifier \(packIdentifier).")
                            }
                            fatalError("\(packName) must have an identifier and it must be unique.")
                        }
                        
                        
                        var stickerPack: StickerPack?
                        do {
                            stickerPack = try StickerPack(identifier: packIdentifier!, name: packName, publisher: packPublisher, trayImageFileName: packTrayImageFileName, publisherWebsite: packPublisherWebsite, privacyPolicyWebsite: packPrivacyPolicyWebsite, licenseAgreementWebsite: packLicenseAgreementWebsite)
                        } catch StickerPackError.fileNotFound {
                            fatalError("\(packTrayImageFileName) not found.")
                        } catch StickerPackError.emptyString {
                            fatalError("The name, identifier, and publisher strings can't be empty.")
                        } catch StickerPackError.unsupportedImageFormat(let imageFormat) {
                            fatalError("\(packTrayImageFileName): \(imageFormat) is not a supported format.")
                        } catch StickerPackError.imageTooBig(let imageFileSize) {
                            let roundedSize = round((Double(imageFileSize) / 1024) * 100) / 100;
                            fatalError("\(packTrayImageFileName): \(roundedSize) KB is bigger than the max tray image file size (\(Limits.MaxTrayImageFileSize / 1024) KB).")
                        } catch StickerPackError.incorrectImageSize(let imageDimensions) {
                            fatalError("\(packTrayImageFileName): \(imageDimensions) is not compliant with tray dimensions requirements, \(Limits.TrayImageDimensions).")
                        } catch StickerPackError.animatedImagesNotSupported {
                            fatalError("\(packTrayImageFileName) is an animated image. Animated images are not supported.")
                        } catch StickerPackError.stringTooLong {
                            fatalError("Name, identifier, and publisher of sticker pack must be less than \(Limits.MaxCharLimit128) characters.")
                        } catch {
                            fatalError(error.localizedDescription)
                        }
                        
                        let stickers: [[String: Any]] = pack["stickers"] as! [[String: Any]]
                        for sticker in stickers {
                            let emojis: [[String: Any]] = sticker["emojis"] as! [[String: Any]]
                            
                            var stickerEmojis = [String]()
                            for emoji in emojis {
                                stickerEmojis.append(emoji["emoji"] as! String)
                            }
                             let filename = sticker["image_file"] as! String
                            
                            do {
                                let urlToSearch = FileManager.documentDirectoryURL.appendingPathComponent(filename).appendingPathExtension("webp")
                                let savedSticker = try Data(contentsOf: urlToSearch)
                                let imageData = ImageData.init(data: savedSticker, type: ImageDataExtension.webp)
                                
                                let image = imageData.image!
                                let widthInPixels = image.size.width * image.scale
                                let heightInPixels = image.size.height * image.scale
                                
                                if (widthInPixels == 512 && heightInPixels == 512) {
                                    let webPData = imageData.webpData
                                    if (Double(webPData!.count) >= 102400) {
                                        continue
                                    }
                                
                                    try stickerPack!.addSticker(imageData: webPData!, type: ImageDataExtension.webp, emojis: stickerEmojis)
                                } else {
                                    let compressed = image.resizeToMaxSizeInKB(sizeInkb: 100)
                                    let resized = StickerDownloadManager.proResizer(imageToResize: compressed!, withSize: CGSize(width: 512, height: 512))
                                    
                                    let image = image.overlayed(with: resized!, canvasSize: CGSize(width: 512, height: 512))
                                    let imageData = UIImagePNGRepresentation(image!)
                                    
//                                    print("correcto?" , resized!)
//                                    print("byte size", imageData)
                                    let pngData = ImageData(data: imageData!, type: .png)
                                    
                                    try stickerPack!.addSticker(imageData: pngData.webpData!, type: ImageDataExtension.webp, emojis: stickerEmojis)
                          
                                }
                            

                            } catch StickerPackError.stickersNumOutsideAllowableRange {
                                fatalError("Sticker count outside the allowable limit (\(Limits.MaxStickersPerPack) stickers per pack).")
                            } catch StickerPackError.fileNotFound {
                                fatalError("\(filename) not found.")
                            } catch StickerPackError.unsupportedImageFormat(let imageFormat) {
                                fatalError("\(filename): \(imageFormat) is not a supported format.")
                            } catch StickerPackError.imageTooBig(let imageFileSize) {
                                let roundedSize = round((Double(imageFileSize) / 1024) * 100) / 100;
                                fatalError("\(filename): \(roundedSize) KB is bigger than the max file size (\(Limits.MaxStickerFileSize / 1024) KB).")
                            } catch StickerPackError.incorrectImageSize(let imageDimensions) {
                                fatalError("\(filename): \(imageDimensions) is not compliant with sticker images dimensions, \(Limits.ImageDimensions).")
                            } catch StickerPackError.animatedImagesNotSupported {
                                fatalError("\(filename) is an animated image. Animated images are not supported.")
                            } catch StickerPackError.tooManyEmojis {
                                fatalError("\(filename) has too many emojis. \(Limits.MaxEmojisCount) is the maximum number.")
                            } catch {
                                fatalError(error.localizedDescription)
                            }
                        }
                        
                        guard stickers.count >= Limits.MinStickersPerPack else {
                            fatalError("Sticker count smaller that the allowable limit (\(Limits.MinStickersPerPack) stickers per pack).")
                        }
                        stickerPacks.append(stickerPack!)
                    }
                    
                    DispatchQueue.main.async {
                        completionHandler(stickerPacks)
                    }
                }
        
            })
    }
        
}



