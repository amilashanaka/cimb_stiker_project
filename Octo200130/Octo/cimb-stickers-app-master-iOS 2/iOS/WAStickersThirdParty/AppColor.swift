//
//  Constants.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 3/25/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import Foundation
import UIKit

struct AppColor {
    private struct Alphas {
        static let Opaque = CGFloat(1)
        static let SemiOpaque = CGFloat(0.8)
        static let SemiTransparent = CGFloat(0.5)
        static let Transparent = CGFloat(0.3)
    }
    
    static let appPrimaryColor =  UIColor.white.withAlphaComponent(Alphas.SemiOpaque)
    static let appSecondaryColor =  UIColor.blue.withAlphaComponent(Alphas.Opaque)
    static let SalmonRed = hexStringToUIColor(hex: "#ec1d23")
    static let SalmonRedDark = UIColor.init(hexString: "#8B0000")
    
    static let shadowGray = UIColor.init(hexString: "d8d8d8")
    static let Success = UIColor.init(hexString: "58b957")
    static let Error = UIColor.init(hexString: "db524b")
    static let BackgroundGray = UIColor.init(hexString: "#ECECEC")
    static let LightGray = UIColor.init(hexString: "9F9F9F")
    
    struct TabBarColors{
        static let Selected = UIColor.white
        static let NotSelected = UIColor.black
    }
    
    struct OverlayColor {
        static let SemiTransparentBlack = UIColor.black.withAlphaComponent(Alphas.Transparent)
        static let SemiOpaque = UIColor.black.withAlphaComponent(Alphas.SemiOpaque)
        static let demoOverlay = UIColor.black.withAlphaComponent(0.6)
    }
}
