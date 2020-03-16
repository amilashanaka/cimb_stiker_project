//
//  ShadowButton.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 4/10/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import Foundation

import UIKit

final class ShadowButton: UIButton {
    
    var fillColors: CGColor
    
    required init(filledBgColor: CGColor = UIColor.black.cgColor) {
        // set myValue before super.init is called
        self.fillColors = filledBgColor
        
        super.init(frame: .zero)

        
        // set other operations after super.init, if required
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 25).cgPath
        shadowLayer.fillColor = fillColors
        
        shadowLayer.shadowColor = AppColor.shadowGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0, height: 3)
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 2
        
        layer.insertSublayer(shadowLayer, at: 0)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
    }
    
}
