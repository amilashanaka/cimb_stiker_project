// Dadtosis

import Foundation
import Toast_Swift

class PrivacyPolicyController: UIViewController {
    // MARK: - Properties
    let width = Constants.screenWidth
    let height = Constants.screenHeight
    
    let titleTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Privacy Policy"
        label.textColor = AppColor.SalmonRed
        label.font = UIFont(name: Constants.FONT_FAMILY_BOLD , size: 16)
        label.textAlignment = .center
        return label
    }()
    
    let privacyPolicyTextView: UITextView = {
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
        textView.isEditable = false
        textView.clipsToBounds = true
        textView.text = App.privacyPolicy
        return textView
    }()
    
    // MARK: - Init
    override func viewDidLayoutSubviews() {
        self.privacyPolicyTextView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - UI
    private func setupUI() {
        self.title = "PRIVACY POLICY"
        addCloseButton(presentationStyle: PresentationStyle.Present)
//        addHomeButton()
        view.backgroundColor = AppColor.BackgroundGray
        view.addSubview(titleTextLabel)
        view.addSubview(privacyPolicyTextView)
        addAutoLayoutConstraints()
    }
    
    private func addAutoLayoutConstraints() {
        let margins = view.layoutMarginsGuide
        privacyPolicyTextView.widthAnchor.constraint(equalToConstant: width * 0.9).isActive = true
        privacyPolicyTextView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 16).isActive = true
        privacyPolicyTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        privacyPolicyTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
    }
}
