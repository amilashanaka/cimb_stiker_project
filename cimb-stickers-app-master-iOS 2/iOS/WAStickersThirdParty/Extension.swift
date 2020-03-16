//
//  Extension.swift
//  WAStickersThirdParty
//
//  Created by AXAT Mac mini 3 (2019) on 30/12/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import UIKit


//extension UIImage {
//    class func imageWithView(image: UIImageView) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(image.bounds.size, image.isOpaque, 0.0)
//        image.drawHierarchy(in: image.bounds, afterScreenUpdates: true)
//        let img = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return img!
//    }
//}


extension UIImage {
    class func imageWithView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
