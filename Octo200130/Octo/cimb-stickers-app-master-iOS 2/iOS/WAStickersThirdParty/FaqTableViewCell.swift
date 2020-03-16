//
//  FaqTableViewCell.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 4/3/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import UIKit
import FontAwesome_swift

protocol FaqTableViewCellDelegate {
    func didClickCaretButton(index: Int)
}

class FaqTableViewCell: UITableViewCell {
    // MARK: - Properties
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var caretBtn: UIButton!
    
    var question: String?
    var answer: String?
    var isExpanded: Bool!
    var index: Int!
    var delegate: FaqTableViewCellDelegate?
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - UI
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        questionTextView.textColor = AppColor.SalmonRed
        questionTextView.font = UIFont(name: Constants.FONT_FAMILY_SEMIBOLD , size: 12)
        questionTextView.isUserInteractionEnabled = false
        
        answerTextView.font = UIFont(name: Constants.FONT_FAMILY_SEMIBOLD , size: 12)
        answerTextView.isUserInteractionEnabled = false
        
        caretBtn.titleLabel?.font = UIFont.fontAwesome(ofSize: 30)
        caretBtn.setTitleColor(AppColor.SalmonRed, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let question = question {
            questionTextView.text = question
        }
        if let answer = answer {
            answerTextView.text = answer
        }
        
        configureExpanded()
    }
    
    func configureExpanded() {
        if isExpanded {
            caretBtn.setTitle(String.fontAwesomeIcon(name: .angleUp), for: .normal)
            answerTextView.isHidden = false
        } else {
            caretBtn.setTitle(String.fontAwesomeIcon(name: .angleDown), for: .normal)
            answerTextView.isHidden = true
        }
    }
    
    @IBAction func caretBtnTapped(_ sender: Any) {
        print("caret tapped", index!)
        delegate?.didClickCaretButton(index: index!)
    }
}
