//
//  UIViewController+BackButtonExt.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 4/3/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import Foundation

enum PresentationStyle: String {
    case Push = "Push"
    case Present = "Present"
}

extension UIViewController {
    func addCloseButton(presentationStyle: PresentationStyle) {
        let resizedImg = #imageLiteral(resourceName: "back").resizeImage(targetSize: CGSize(width: 20, height: 20))
        let original = resizedImg.withRenderingMode(.alwaysOriginal)
        var button = UIBarButtonItem()
        if (presentationStyle.rawValue == "Push") {
            button = UIBarButtonItem(image: original,
                                         landscapeImagePhone: nil,
                                         style: .done,
                                         target: self,
                                         action: #selector(onClosePushed))
        } else if (presentationStyle.rawValue == "Present") {
            button = UIBarButtonItem(image: original,
                                         landscapeImagePhone: nil,
                                         style: .done,
                                         target: self,
                                         action: #selector(onClose))
        }
        navigationItem.leftBarButtonItem = button
    }
    
    @objc func onClose(){
        self.navigationController?.navigationBar.tintColor = AppColor.SalmonRed
        self.dismiss(animated: true, completion: nil)
    }
        // back Button Tint when closing
    @objc func onClosePushed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func addHomeButton() {
        let resizedImg = #imageLiteral(resourceName: "home").resizeImage(targetSize: CGSize(width: 24, height: 24))
        let original = resizedImg.withRenderingMode(.alwaysOriginal)
        let button = UIBarButtonItem(image: original,
                                     landscapeImagePhone: nil,
                                     style: .done,
                                     target: self,
                                     action: #selector(onClose))
        navigationItem.rightBarButtonItem = button
    }
}

