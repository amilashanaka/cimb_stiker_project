//
//  MakeSuggestions.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 3/26/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import Foundation
import Toast_Swift

private let reuseIdentifier = "MenuOptionCell"
private let placeHolderText = "Write your suggestion here (400 Characters Max)"
// if you change placeHolderText be sure to update Validator.validTextView class

// embed home & menu into Container Controller
class SuggestionsController: UIViewController {
    // MARK: - Properties
    let width = Constants.screenWidth
    let height = Constants.screenHeight
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.showsHorizontalScrollIndicator = false
        v.showsVerticalScrollIndicator = false
        return v
    }()
    
    let titleTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "We want to hear from you! Tell us what stickers you would like to see next."
        label.textColor = UIColor.black
        label.font = UIFont(name: Constants.FONT_FAMILY_SEMIBOLD , size: 14)
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    
    let letUsKnowTextView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.text = "LET US KNOW!"
        tv.font = UIFont(name: Constants.FONT_FAMILY_BOLD , size: 16)
        tv.textColor = AppColor.SalmonRed
        tv.textAlignment = .center
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.textAlignment = .center
        tv.backgroundColor = UIColor.clear
        return tv
    }()
    
    let emailTextField: ShadowTextField = {
        let textField = ShadowTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter your email here"
        textField.font = UIFont(name: Constants.FONT_FAMILY , size: 14)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.layer.cornerRadius = 25
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.clipsToBounds = false
        return textField
    }()
    

    let inputTextView: ShadowTextView = {
        let textView = ShadowTextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = placeHolderText
        textView.font = UIFont(name: Constants.FONT_FAMILY , size: 14)
        textView.autocorrectionType = UITextAutocorrectionType.no
        textView.keyboardType = UIKeyboardType.default
        textView.returnKeyType = UIReturnKeyType.done
        textView.textContainerInset = UIEdgeInsetsMake(16, 16, 16, 16)
        textView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
        textView.isScrollEnabled = true
        textView.clipsToBounds = false
        return textView
    }()
    
    let submitFormBtn: UIButton = {
        let button = ShadowButton(filledBgColor: AppColor.SalmonRed.cgColor)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SUBMIT", for: .normal)
        button.addTarget(self, action: #selector(onSubmitSuggestion), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont(name: Constants.FONT_FAMILY_SEMIBOLD, size: 14)
        return button
    }()

    // MARK: - Init
    override func viewDidLayoutSubviews() {
        scrollView.delegate = self
//        scrollView.contentSize = CGSize(width:self.view.frame.size.width, height: 1000) // set height according you
        let scrollSize = CGSize(width: self.view.frame.size.width - 2000,
                                height: self.view.frame.size.height)
        scrollView.contentSize = scrollSize
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SUGGESTION"
        addGesture()
        view.backgroundColor = AppColor.BackgroundGray
        
        view.addSubview(scrollView)
        scrollView.addSubview(titleTextLabel)
        scrollView.addSubview(letUsKnowTextView)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(inputTextView)
        scrollView.addSubview(submitFormBtn)
        
        emailTextField.delegate = self
        inputTextView.delegate = self
        emailTextField.becomeFirstResponder()
        
        inputTextView.text = placeHolderText
        inputTextView.textColor = .lightGray
        
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(true)
            addCloseButton(presentationStyle: PresentationStyle.Push)
           self.navigationController?.navigationBar.isHidden = false
       }
  
    // MARK: - Handlers
//    @objc func onBack() {
//        if (inputTextView.text != "" || inputTextView.text.replacingOccurrences(of: " ", with: "") != "") {
//            let alert = UIAlertController(title:"Attention!", message:"Are you sure you want to leave without filling up our form?", preferredStyle: .alert);
//
//            //CUSTOM ACTION HANDLER
//            let action1 = UIAlertAction(title: "Yes", style: .default, handler: {
//                action in
//                self.dismiss(animated: true, completion: nil)
//            })
//            let action2 = UIAlertAction(title:"Back to Form", style: .cancel, handler:  {
//                action in
//                print("back to form")
//            })
//            alert.addAction(action1);
//            alert.addAction(action2);
//
//            present(alert, animated:true, completion:nil)
//        } else {
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
    
    func validateFormFields() -> String {
        if !(Validator.isValidEmail(testStr: emailTextField.text!)) {
            return "Please enter a valid email."
        } else if !(Validator.validTextView(textView: inputTextView)) {
            return "Oops! You forgot to enter your suggestion."
        } else {
            return "Form Submitted!"
        }
    }
    
    @objc func onSubmitSuggestion(_ : UIButton) {
        var style = ToastStyle()
        let message = validateFormFields()
        style.titleFont = UIFont(name: Constants.FONT_FAMILY_BOLD, size: 16)!
        style.messageFont = UIFont(name: Constants.FONT_FAMILY, size: 16)!
        style.messageColor = UIColor.white
        style.backgroundColor = AppColor.Error
        
        self.view.makeToast(message, duration: 3.0, position: .center, style: style)
        
        if (message != "Form Submitted!" ) {
            return
        }
        
        let parameters = ["email": emailTextField.text!, "description": String(inputTextView.text)]
        
        //create the url with URL
        let url = URL(string: HTTP.POST_SUGGESTION)!
        
        //create session
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                    self.dismiss(animated: true, completion: nil)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    @objc func dismissTextViewKeyboard(sender : UITapGestureRecognizer) {
        inputTextView.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }
    
    // MARK: - UI
    func addGesture() {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.dismissTextViewKeyboard))
        self.view.addGestureRecognizer(gesture)
    }
    private func setupLayout() {
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0).isActive = true
        
        titleTextLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
        titleTextLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24).isActive = true
            titleTextLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            titleTextLabel.heightAnchor.constraint(equalToConstant: height*0.08).isActive = true
            titleTextLabel.widthAnchor.constraint(equalToConstant: width*0.85).isActive = true
        
            letUsKnowTextView.topAnchor.constraint(equalTo: titleTextLabel.bottomAnchor, constant: 12).isActive = true
            letUsKnowTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            letUsKnowTextView.heightAnchor.constraint(equalToConstant: height*0.05).isActive = true
            letUsKnowTextView.widthAnchor.constraint(equalToConstant: width*0.5).isActive = true
        
            emailTextField.widthAnchor.constraint(equalToConstant: width * 0.85).isActive = true
            emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
            emailTextField.topAnchor.constraint(equalTo: letUsKnowTextView.bottomAnchor, constant: 12).isActive = true
            emailTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            emailTextField.setLeftPaddingPoints(15)
            emailTextField.setRightPaddingPoints(15)
        
            inputTextView.widthAnchor.constraint(equalToConstant: width * 0.85).isActive = true
            inputTextView.heightAnchor.constraint(equalToConstant: height * 0.4).isActive = true
            inputTextView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12).isActive = true
            inputTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

            submitFormBtn.widthAnchor.constraint(equalToConstant: width * 0.65).isActive = true
            submitFormBtn.heightAnchor.constraint(equalToConstant: height * 0.08).isActive = true
            submitFormBtn.topAnchor.constraint(equalTo: inputTextView.bottomAnchor, constant: 16).isActive = true
            submitFormBtn.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        }
    
}
// MARK: - Extensions
extension SuggestionsController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("didBeginEditingcalled")
        if (textView.text == placeHolderText && textView.textColor == .lightGray)
        {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("didEndEdditing called")
        if (textView.text == "" || textView.text.replacingOccurrences(of: " ", with: "") == "")
        {
            textView.text = placeHolderText
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        
        return textView.text.count + (text.count - range.length) <= 400
    }
    
    
}

extension SuggestionsController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            emailTextField.resignFirstResponder()
            inputTextView.becomeFirstResponder()
            return false
        }
        return true
    }
}
