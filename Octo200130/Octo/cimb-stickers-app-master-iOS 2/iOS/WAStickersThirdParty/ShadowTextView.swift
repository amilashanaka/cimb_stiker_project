//
//  ShadowButton.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 4/10/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import Foundation

import UIKit

final class ShadowTextField: UITextField {
    
    required init() {
        // set myValue before super.init is called
        
        super.init(frame: CGRect.zero)
        
        layer.masksToBounds = false
        layer.shadowRadius = 0.5
        layer.shadowOpacity = 1
        layer.shadowColor = AppColor.shadowGray.cgColor
        layer.shadowOffset = CGSize(width: 0 , height:4)
        // set other operations after super.init, if required
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
}
