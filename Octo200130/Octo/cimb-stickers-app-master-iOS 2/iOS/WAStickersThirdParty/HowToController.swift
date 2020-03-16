//
//  HowToController.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 4/10/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import Foundation

class HowToController: UIViewController {
    // MARK: - Properties
    private let firstLabelText = "Tap here to explore our app or to get help."
    private var overlay: UIView!
    private var buttons = [UIButton]()
    private var labels = [UILabel]()
    private var counter = 0
    
    // MARK: - Init
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHowToOverlay()
        buttons[counter].isHidden = false
        labels[counter].isHidden = false
    }
    
    // MARK: - HANDLERS
    @objc func tutorialNextStep() {
        // print(counter)
        let isButtonIndexValid = buttons.indices.contains(counter + 1)
        let isLabelIndexValid = labels.indices.contains(counter + 1)
        
        if (isButtonIndexValid && isLabelIndexValid) {
            buttons[counter].isHidden = true
            labels[counter].isHidden = true
            buttons[counter + 1].isHidden = false
            labels[counter + 1].isHidden = false
            
            if (counter + 1 == buttons.count - 1) {
                buttons.last?.setTitle("DONE", for: .normal)
                buttons.last!.addTarget(self, action: #selector(self.tutorialHidden), for: .touchUpInside)
            }
        }
        counter += 1
    }
    
    @objc func tutorialHidden() {
//        let TutorialVC = HomeVC()
        self.navigationController?.popViewController(animated: false)
            overlay.isHidden = true
//            counter = 0
//            buttons.last?.setTitle("NEXT", for: .normal)
//            buttons[counter].isHidden = false
//            labels[counter].isHidden = false
//            buttons.last!.removeTarget(self, action: #selector(self.tutorialHidden), for: .touchUpInside)
//            buttons.last!.addTarget(self, action: #selector(self.tutorialNextStep), for: .touchUpInside)
//            self.tabBarController?.selectedIndex = 0
    }
    
    // MARK: - UI
    func configureHowToOverlay() {
        overlay = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        
        view.addFullScreenBackgroundImage(withImageName: "howToScreen.png", contentMode: .scaleAspectFit)
        view.addSubview(overlay)
        
        let button1 = UIButton()
        let button2 = UIButton()
        let button3 = UIButton()
        let button4 = UIButton()
        let button5 = UIButton()
        let button6 = UIButton()
        let label1 = UILabel()
        let label2 = UILabel()
        let label3 = UILabel()
        let label4 = UILabel()
        let label5 = UILabel()
        let label6 = UILabel()
        
        buttons.append(button1)
        buttons.append(button2)
        buttons.append(button3)
        buttons.append(button4)
        buttons.append(button5)
        buttons.append(button6)
        labels.append(label1)
        labels.append(label2)
        labels.append(label3)
        labels.append(label4)
        labels.append(label5)
        labels.append(label6)
        
        button1.setTitle("1", for: .normal)
        button2.setTitle("2", for: .normal)
        button3.setTitle("3", for: .normal)
        button4.setTitle("4", for: .normal)
        button5.setTitle("5", for: .normal)
        button6.setTitle("NEXT", for: .normal)
        button6.addTarget(self, action: #selector(self.tutorialNextStep), for: .touchUpInside)
        
        label1.text = firstLabelText
        label2.text = "Search stickers for all situations."
        label3.text = "Something caught your eye? Tap on a sticker pack to preview it."
        label4.text = "Love this? Tap here to add it to your WhatsApp keyboard tray."
        label5.text = "You have saved this sticker!"
        
        overlay.addSubview(button1)
        overlay.addSubview(button2)
        overlay.addSubview(button3)
        overlay.addSubview(button4)
        overlay.addSubview(button5)
        overlay.addSubview(button6)
        
        overlay.addSubview(label1)
        overlay.addSubview(label2)
        overlay.addSubview(label3)
        overlay.addSubview(label4)
        overlay.addSubview(label5)
        
        styleOverlay()
        
        let margins = view.layoutMarginsGuide
        button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
        button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button1.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        label1.centerYAnchor.constraint(equalTo: button1.centerYAnchor).isActive = true
        label1.heightAnchor.constraint(equalTo: button1.heightAnchor, multiplier: 1.0).isActive = true
        label1.leadingAnchor.constraint(equalTo: button1.trailingAnchor, constant: 8).isActive = true
        label1.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        button2.topAnchor.constraint(equalTo: view.topAnchor, constant: 106).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button2.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button2.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 12).isActive = true
        
        label2.centerYAnchor.constraint(equalTo: button2.centerYAnchor).isActive = true
        label2.heightAnchor.constraint(equalTo: button2.heightAnchor, multiplier: 1.0).isActive = true
        label2.leadingAnchor.constraint(equalTo: button2.trailingAnchor, constant: 8).isActive = true
        label2.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        button3.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -32).isActive = true
        button3.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button3.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button3.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 12).isActive = true
        
        label3.centerYAnchor.constraint(equalTo: button3.centerYAnchor).isActive = true
        label3.heightAnchor.constraint(equalTo: button3.heightAnchor, multiplier: 1.0).isActive = true
        label3.leadingAnchor.constraint(equalTo: button3.trailingAnchor, constant: 8).isActive = true
        label3.widthAnchor.constraint(equalToConstant: view.frame.width - 200).isActive = true
        
        button4.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button4.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button4.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        label4.topAnchor.constraint(equalTo: button4.topAnchor, constant: 32).isActive = true
        label4.heightAnchor.constraint(equalTo: button4.heightAnchor, multiplier: 1.0).isActive = true
        label4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        label4.widthAnchor.constraint(equalToConstant: view.frame.width - 150).isActive = true
        
        button5.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button5.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button5.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button5.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        label5.topAnchor.constraint(equalTo: button4.topAnchor).isActive = true
        label5.heightAnchor.constraint(equalTo: button4.heightAnchor, multiplier: 1.0).isActive = true
        label5.trailingAnchor.constraint(equalTo: button5.trailingAnchor, constant: -12).isActive = true
        label5.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        button6.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button6.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button6.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6, constant: 0).isActive = true
        button6.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height * 0.2).isActive = true
    }
    
    
    func styleOverlay() {
        // loop through and style buttons & labels
        for view in overlay.subviews as [UIView] {
            if let btn = view as? UIButton {
                btn.clipsToBounds = true
                btn.layer.cornerRadius = 20
                btn.backgroundColor = AppColor.SalmonRed
                btn.setTitleColor(UIColor.white, for: .normal)
                btn.titleLabel?.font = UIFont(name: Constants.FONT_FAMILY_BOLD, size: 16)
                btn.translatesAutoresizingMaskIntoConstraints = false
                btn.isHidden = true
                
                if btn.currentTitle == "NEXT" {
                    btn.backgroundColor = UIColor.clear
                    btn.layer.borderColor = UIColor.white.cgColor
                    btn.layer.borderWidth = 1.5
                    btn.isHidden = false
                }
            }
            
            if let label = view as? UILabel {
                label.translatesAutoresizingMaskIntoConstraints = false
                label.adjustsFontSizeToFitWidth = true
                label.font = UIFont(name: Constants.FONT_FAMILY_SEMIBOLD , size: 12)
                label.textColor = UIColor.white
                label.numberOfLines = 0
                label.isHidden = true
            }
        }
    }
}
