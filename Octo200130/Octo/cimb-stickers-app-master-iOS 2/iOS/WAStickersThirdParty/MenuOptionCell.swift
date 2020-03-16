//
//  MenuOptionCell.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 3/26/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import UIKit

class MenuOptionCell: UITableViewCell {

    // MARK: - Properties
    lazy var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    var menuTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.SalmonRedDark
        label.font = UIFont(name: Constants.FONT_FAMILY , size: 14)
        label.text = "sampleText"
        return label
    }()
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(iconImageView)
        addSubview(menuTitleLabel)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        menuTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 9.0, *) {
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
            iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
            iconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
            menuTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            menuTitleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 12).isActive = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handlers

}
