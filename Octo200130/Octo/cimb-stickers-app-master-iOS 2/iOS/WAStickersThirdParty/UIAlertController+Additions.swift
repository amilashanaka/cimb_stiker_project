//
// Copyright (c) WhatsApp Inc. and its affiliates.
// All rights reserved.
//
// This source code is licensed under the BSD-style license found in the
// LICENSE file in the root directory of this source tree.
//

import UIKit

extension UIAlertController {
    
    // NOTE: Add spinner does not add the Custom Spinner. it adds a plain spinner
    // for custom loader use the singleton class found in CustomLoader.swift
    func addSpinner() {
        let activity: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.addSubview(activity)
        

        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.addConstraint(NSLayoutConstraint(item: activity, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: activity.bounds.size.width))
        activity.addConstraint(NSLayoutConstraint(item: activity, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: activity.bounds.size.height))
        view.addConstraint(NSLayoutConstraint(item: activity, attribute: .centerXWithinMargins, relatedBy: .equal, toItem: view, attribute: .centerXWithinMargins, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: activity, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: -20.0))

        activity.startAnimating()
    }

    func addImageView(withImage image: UIImage) {
        var stickerImageViewLength: CGFloat = 100.0
        if #available(iOS 9.0, *) {
            stickerImageViewLength = 125
        }

        let stickerImageView: UIImageView = UIImageView(image: image)
        stickerImageView.translatesAutoresizingMaskIntoConstraints = false;
        view.addSubview(stickerImageView)

        stickerImageView.addConstraint(NSLayoutConstraint(item: stickerImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: stickerImageViewLength))
        stickerImageView.addConstraint(NSLayoutConstraint(item: stickerImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: stickerImageViewLength))
        view.addConstraint(NSLayoutConstraint(item: stickerImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 10.0))
        view.addConstraint(NSLayoutConstraint(item: stickerImageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
    }
}

struct CustomAlerts {
    // NOTE: custom alerts must be pure functions, they cannot call functions in the VC
    static func whatsappNotInstalledAlert() -> UIAlertController {
        let alert = UIAlertController(title:"WhatsApp not installed", message:"Looks like you don’t have WhatsApp on your device. Download it now to start sending stickers!", preferredStyle: .alert);
        
        let action1 = UIAlertAction(title: "Ok", style: .default, handler: {
            action in
            print("YES")
        })
        alert.addAction(action1);
        
        return alert
    }
    
    static func noInternetConnectionAlert() -> UIAlertController {
        let alert = UIAlertController(title:"Oops!", message:"You don't seem to be connected to the internet. Please exit and try again later.", preferredStyle: .alert);
        
        let action1 = UIAlertAction(title: "Ok", style: .default, handler: {
            action in
            print("Internet Connection Unavailable Acknowledged.")
        })
        
        alert.addAction(action1);
        
        return alert
    }
}
