//
//  MenuController.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 3/26/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import Foundation

private let reuseIdentifier = "MenuOptionCell"
// embed home & menu into Container Controller
class MenuController: UIViewController {
    // MARK: - Properties
    var tableView: UITableView!
    var delegate: HomeControllerDelegate?
    var menuTopPadding: CGFloat?
    
    lazy var footerAppVersionLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "App version \(Constants.APP_VERSION)"
        label.textColor = UIColor.black
        label.font = UIFont(name: Constants.FONT_FAMILY_SEMIBOLD , size: 12)
        label.textAlignment = .center
        return label
    }()
    
    lazy var footerCopyrightLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.APP_COPYRIGHT
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont(name: Constants.FONT_FAMILY_SEMIBOLD , size: 12)
        label.textAlignment = .left
        return label
    }()
    
    lazy var termsMenuFooterBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("TERMS & CONDITIONS", for: .normal)
        button.addTarget(self, action: #selector(termsMenuFooterBtnTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: Constants.FONT_FAMILY, size: 12)
        button.setTitleColor(AppColor.SalmonRed, for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    lazy var privacyPolicyFooterBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("PRIVACY POLICY", for: .normal)
        button.addTarget(self, action: #selector(privacyPolicyFooterBtnTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: Constants.FONT_FAMILY, size: 12)
        button.setTitleColor(AppColor.SalmonRed, for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    // MARK: - Init
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        configureTableView()
        configureTableViewFooter()
    }
    
    // MARK: - Handlers
    @objc func privacyPolicyFooterBtnTapped() {
        print("Privacy Policy")
        let vc = PrivacyPolicyController()
        present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    @objc func termsMenuFooterBtnTapped() {
        print("T&C Tapped")
        let vc = TermsAndConditionsController()
        vc.isFromMenu = true
            present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    // MARK: - UI
    func configureTableViewFooter() {
        let footerView: UIView = UIView()
        footerView.frame = CGRect(x: 0, y: self.view.bounds.height - 100, width: self.view.bounds.width, height: 100)

        footerView.addSubview(footerAppVersionLbl)
        footerView.addSubview(footerCopyrightLbl)
        footerView.addSubview(termsMenuFooterBtn)
        footerView.addSubview(privacyPolicyFooterBtn)
        view.addSubview(footerView)
        
        footerAppVersionLbl.topAnchor.constraint(equalTo: footerView.topAnchor).isActive = true
        footerAppVersionLbl.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 32).isActive = true
        footerAppVersionLbl.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        footerCopyrightLbl.topAnchor.constraint(equalTo: footerAppVersionLbl.bottomAnchor, constant: 0).isActive = true
        footerCopyrightLbl.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 32).isActive = true
        footerCopyrightLbl.widthAnchor.constraint(equalTo: footerView.widthAnchor, multiplier: 0.7).isActive = true
        footerCopyrightLbl.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        termsMenuFooterBtn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        termsMenuFooterBtn.topAnchor.constraint(equalTo: footerCopyrightLbl.bottomAnchor).isActive = true
        termsMenuFooterBtn.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 32).isActive = true
        termsMenuFooterBtn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        privacyPolicyFooterBtn.topAnchor.constraint(equalTo: footerCopyrightLbl.bottomAnchor).isActive = true
        privacyPolicyFooterBtn.leadingAnchor.constraint(equalTo: termsMenuFooterBtn.trailingAnchor, constant: 16).isActive = true
        privacyPolicyFooterBtn.widthAnchor.constraint(equalTo: termsMenuFooterBtn.widthAnchor, multiplier: 1.0).isActive = true
        privacyPolicyFooterBtn.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.rowHeight = 60        
        tableView.isScrollEnabled = false
        tableView.clipsToBounds = false
        tableView.layer.masksToBounds = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        if #available(iOS 9.0, *) {
            menuTopPadding = Constants.screenHeight * 0.1
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: menuTopPadding!).isActive = true
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        }
       
    }
}

// MARK: - Extensions
extension MenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOption.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MenuOptionCell
        let menuOption = MenuOption(rawValue: indexPath.row)
        cell.iconImageView.image = menuOption?.image
        cell.menuTitleLabel.text = menuOption?.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMenuOption = MenuOption(rawValue: indexPath.row)
        delegate?.handleMenuToggle(forMenuOption: selectedMenuOption)
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.selectionStyle = .none
    }
    
}

