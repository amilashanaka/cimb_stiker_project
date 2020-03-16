//
//  Validation.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 3/28/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import Foundation

let __firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
let __serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
let __emailRegex = __firstpart + "@" + __serverpart + "[A-Za-z]{2,8}"
let __emailPredicate = NSPredicate(format: "SELF MATCHES %@", __emailRegex)

extension String {
    func isEmail() -> Bool {
        return __emailPredicate.evaluate(with: self)
    }
}

// returns True or False Only!
class Validator {
    static func validTextView(textView: UITextView) -> Bool {
        let trimmed = textView.text.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        print("trimmed is:\(trimmed)")
        if trimmed == "" || trimmed == "Write your suggestion here (400 Characters Max)" {
            return false
        }
        
        return true
    }
    
    static func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}

