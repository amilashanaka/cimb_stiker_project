//
//  TermsAndConditionsController.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 4/4/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import Foundation
import Toast_Swift

class TermsAndConditionsController: UIViewController {
    // MARK: - Properties
    let width = Constants.screenWidth
    let height = Constants.screenHeight
    var delegate: isDismissedFromTerms?
    var isFromMenu: Bool?
    
    let titleTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TERMS & CONDITIONS"
        label.textColor = AppColor.SalmonRed
        label.font = UIFont(name: Constants.FONT_FAMILY_BOLD , size: 16)
        label.textAlignment = .center
        return label
    }()
    
    let termsTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: Constants.FONT_FAMILY , size: 14)
        textView.autocorrectionType = UITextAutocorrectionType.no
        textView.textContainerInset = UIEdgeInsetsMake(16, 16, 16, 16)
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.gray.withAlphaComponent(0.05).cgColor
        textView.layer.borderWidth = 0.5
        textView.backgroundColor = AppColor.BackgroundGray
        textView.isScrollEnabled = true
        textView.showsVerticalScrollIndicator = false
        textView.isSelectable = false
        textView.isEditable = false
        textView.clipsToBounds = true
        
        let hasAgreedToTermsBefore = UserDefaults.standard.bool(forKey: "isTermsAccepted")
        
        if (!hasAgreedToTermsBefore) {
            print("never accepted terms before @ContainerController")
            textView.text = App.termsAndConditionsInit
        } else {
            textView.text = App.termsAndConditions
        }
        return textView
    }()
    
    let acceptBtn: ShadowButton = {
        let button = ShadowButton(filledBgColor: AppColor.SalmonRed.cgColor);
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("I AGREE", for: .normal)
        button.addTarget(self, action: #selector(acceptBtnTapped), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont(name: Constants.FONT_FAMILY_BOLD, size: 14)
        button.backgroundColor = AppColor.SalmonRed
        
        return button
    }()
    
    // MARK: - Init
    override func viewDidLayoutSubviews() {
        self.termsTextView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.clipsToBounds = true
        view.backgroundColor = AppColor.BackgroundGray
         self.navigationController?.navigationBar.isHidden = false
        let menu = UIBarButtonItem(image: UIImage(named: "ic-menu"),
                                                landscapeImagePhone: nil,
                                                style: .plain,
                                                target: self,
                                                action: #selector(self.menuAction(sender:)))
               
               
                self.navigationItem.leftBarButtonItems = [menu]
        if let _ = isFromMenu {
            self.title = "TERMS & CONDITIONS"
            titleTextLabel.isHidden = true
            acceptBtn.isHidden = true
            addCloseButton(presentationStyle: PresentationStyle.Present)
        } else {
            UIApplication.shared.isStatusBarHidden = true
            self.navigationItem.title = "TERMS & CONDITIONS"
             self.navigationItem.leftBarButtonItems = [menu]
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
        view.addSubview(titleTextLabel)
        view.addSubview(termsTextView)
        view.addSubview(acceptBtn)
        
        setupLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) { 
        super.viewWillDisappear(animated)
      //  UIApplication.shared.isStatusBarHidden = false
    }
    
     @objc func menuAction( sender : UIBarButtonItem){
             
           // self.navigationController?.navigationBar.isHidden =
    //        let SideFadeInOutVC = storyboard?.instantiateViewController(withIdentifier: "SideFadeInOutVC") as! SideFadeInOutVC
    //        // abcViewController.title = "ABC"
    //         navigationController?.pushViewController(SideFadeInOutVC, animated: true)
           // UIView.animate(withDuration: 0.7, delay: 0.4, options: .beginFromCurrentState, animations: {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {() -> Void in
               // self.menuView.layoutIfNeeded()
              //  self.menuView.frame = CGRectEdge(self.view.frame.origin.x, self.view.frame.origin.y, 200, self.view.frame.size.height);
              //  self.menuView.transform = .identity
    //              self.menuView.isHidden = false
    //
    //            self.showMenu()
           
                  }, completion: {(_ finished: Bool) -> Void in
                  })

                  
           // self.menuView.isHidden = false
                 //  self.btnCoverScreen.isUserInteractionEnabled = false
          //  self.showMenu()
                 
              }
    
    // MARK: - Handlers        
    @objc func cancelBtnTapped(button: UIButton) {
        var style = ToastStyle()
        style.titleFont = UIFont(name: Constants.FONT_FAMILY_BOLD, size: 16)!
        style.messageFont = UIFont(name: Constants.FONT_FAMILY, size: 16)!
        style.messageColor = UIColor.white
        style.titleAlignment = .center
        
        let message = "Please Accept Terms & Conditions To Continue."
        self.view.makeToast(message, duration: 2.5, position: .center, style: style)
    }
    
    @objc func acceptBtnTapped(button: UIButton) {
        showFirstTimeTutorial()
    }
    
    func showFirstTimeTutorial() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "isTermsAccepted")
        if let delegate = delegate {
            delegate.pass(data: "Terms")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UI
    private func setupLayout() {
        if let _ = isFromMenu {
            print("im A NINJA HOME")
            let margins = view.layoutMarginsGuide
            
            termsTextView.widthAnchor.constraint(equalToConstant: width * 0.9).isActive = true
            termsTextView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 16).isActive = true
            termsTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            termsTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        } else {
            print("not a ninja")
            titleTextLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
            titleTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            titleTextLabel.heightAnchor.constraint(equalToConstant: height*0.1).isActive = true
            titleTextLabel.widthAnchor.constraint(equalToConstant: width*0.7).isActive = true
            
            termsTextView.widthAnchor.constraint(equalToConstant: width * 0.9).isActive = true
            termsTextView.heightAnchor.constraint(equalToConstant: height * 0.75).isActive = true
            termsTextView.topAnchor.constraint(equalTo: titleTextLabel.bottomAnchor, constant: -12).isActive = true
            termsTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            acceptBtn.widthAnchor.constraint(equalToConstant: width * 0.8).isActive = true
            acceptBtn.heightAnchor.constraint(equalToConstant: height * 0.07).isActive = true
            
            acceptBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
            acceptBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
//            cancelBtn.widthAnchor.constraint(equalTo: acceptBtn.widthAnchor, multiplier: 1.0).isActive = true
//            cancelBtn.heightAnchor.constraint(equalTo: acceptBtn.heightAnchor, multiplier: 1.0).isActive = true
//            cancelBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
//            cancelBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:24).isActive = true
        }
    }
}
