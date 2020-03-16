//
//  MenuOption.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 3/26/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//
import Foundation

enum MenuOption: Int, CustomStringConvertible, CaseIterable {
    // Int
    case StickerPacks
    case HowTo
    case Faqs
    case LeaveSuggestion
    
    var description: String {
        switch self {
        case .StickerPacks: return "STICKER PACKS"
        case .HowTo: return "HOW-TO?"
        case .Faqs: return "FAQS"
        case .LeaveSuggestion: return "LEAVE A SUGGESTION"
        }
    }
        
    var image: UIImage {
        switch self {
        case .StickerPacks: return UIImage(named: "stickerpack") ?? UIImage()
        case .HowTo: return UIImage(named: "howto") ?? UIImage()
        case .Faqs: return UIImage(named: "faq") ?? UIImage()
        case .LeaveSuggestion: return UIImage(named: "suggestion") ?? UIImage()
        }
    }
}
