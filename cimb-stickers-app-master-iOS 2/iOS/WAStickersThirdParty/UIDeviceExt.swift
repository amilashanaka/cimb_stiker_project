//
//  UIDeviceExt.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 7/30/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import Foundation
public extension UIDevice {
    
    public enum PhoneType {
        case iPad
        case iPhone_unknown
        case iPhone_5_5S_5C
        case iPhone_6_6S_7_8
        case iPhone_6_6S_7_8_PLUS
        case iPhone_X_Xs
        case iPhone_Xs_Max
        case iPhone_Xr
    }
    
    public var hasHomeButton: Bool {
        switch type {
        case .iPhone_X_Xs, .iPhone_Xr, .iPhone_Xs_Max:
            return false
        default:
            return true
        }
    }
    
    public var type: PhoneType {
        if userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                return .iPhone_5_5S_5C
            case 1334:
                return .iPhone_6_6S_7_8
            case 1920, 2208:
                return .iPhone_6_6S_7_8_PLUS
            case 2436:
                return .iPhone_X_Xs
            case 2688:
                return .iPhone_Xs_Max
            case 1792:
                return .iPhone_Xr
            default:
                return .iPhone_unknown
            }
        }
        return .iPad
    }
}
