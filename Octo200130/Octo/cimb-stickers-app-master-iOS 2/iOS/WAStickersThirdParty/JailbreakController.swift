//
//  JailbreakController.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 5/11/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import Foundation

// embed home & menu into Container Controller
class JailbreakController: UIViewController {
    // MARK: - Properties
    let titleTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Dear User, you are viewing this message because the app was ran on a JailBroken Device. If this was a false positive please write to our support email at Cimb.stickers@reprisedigital.com. Alternatively you could also try restarting the app."
        label.textColor = UIColor.black
        label.font = UIFont(name: Constants.FONT_FAMILY_SEMIBOLD , size: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let sendMailBtn: UIButton = {
        let button = ShadowButton(filledBgColor: AppColor.SalmonRed.cgColor)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Email Us", for: .normal)
        button.addTarget(self, action: #selector(onEmailUsTapped), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont(name: Constants.FONT_FAMILY_SEMIBOLD, size: 14)
        return button
    }()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addFullScreenBackgroundImage(withImageName: "bg@100.png", contentMode: .scaleAspectFit)
        self.title = "Contact Us"
        view.addSubview(titleTextLabel)
        view.addSubview(sendMailBtn)
        setupLayout()
    }
    
    // MARKL - Handlers
    @objc func onEmailUsTapped() {
        print("emailUsWasCalled")
        let appURL = URL(string: "mailto:Cimb.stickers@reprisedigital.com")!
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
        }
        else {
            UIApplication.shared.openURL(appURL as URL)
        }
    }
    
    // MARK: - UI
    private func setupLayout() {
        titleTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleTextLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -44).isActive = true
        titleTextLabel.widthAnchor.constraint(equalToConstant: Constants.screenWidth * 0.7).isActive = true
        
        sendMailBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendMailBtn.widthAnchor.constraint(equalToConstant: Constants.screenWidth * 0.7).isActive = true
        sendMailBtn.topAnchor.constraint(equalTo: titleTextLabel.bottomAnchor, constant: 12).isActive = true
        sendMailBtn.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
}
