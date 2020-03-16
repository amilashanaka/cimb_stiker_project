//
//  File.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 4/5/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import Foundation

extension FileManager {
    static var documentDirectoryURL: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    // appropriateFor & create is uesless, its the systems job to ensure documentDir is created
    static var documentDirectoryURL2: URL {
        return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
}

// you can right click openURL in playground
//FileManager.documentDirectoryURL
//
//// Create your own URL's with extensions
//let mysteryDataURL = URL(fileURLWithPath: "mysteryFileName", relativeTo: FileManager.documentDirectoryURL).appendingPathExtension("txt")
//
//let stringURL = FileManager.documentDirectoryURL.appendingPathComponent("myFile").appendingPathExtension("txt")
//
//// Convenience
//mysteryDataURL.path
//mysteryDataURL.lastPathComponent
