//
//  HomeController.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 3/26/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

protocol isDismissedFromTerms {
    func pass(data: String)  //data: string is an example parameter
}

class HomeController: UIViewController, isDismissedFromTerms {
    func pass(data: String) {
        StickerPackManager.run(after: 1) {
            if (data == "Terms") {
                print("Initialized From Terms")
                self.tabBarController?.selectedIndex = 1
            }
        }
        
    }
    // MARK: - Properties
    private let cellIdentifier = "StickerPackCell"
    private var stickerPacksTableView: UITableView = UITableView()
    private var stickerPacks: [StickerPack] = []
    private var filteredArray: [StickerPack] = []
    private var selectedIndex: IndexPath?
    private var searchTextField:UITextField!
    
    var isSearching = false
    
    lazy var stickyFooterView: UIStackView = {
        let vi = UIStackView()
        vi.translatesAutoresizingMaskIntoConstraints = false
        vi.axis = .vertical
        vi.distribution = .fillEqually
        vi.addSubview(footerAppVersionLbl)
        vi.addSubview(footerCopyrightLbl)
        vi.addSubview(termsMenuFooterBtn)
        vi.addSubview(privacyPolicyFooterBtn)
        vi.addArrangedSubview(footerAppVersionLbl)
        vi.addArrangedSubview(footerCopyrightLbl)
        vi.addArrangedSubview(termsMenuFooterBtn)
        vi.addArrangedSubview(privacyPolicyFooterBtn)
        return vi
    }()
    
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
        label.textAlignment = .center
     
        return label
    }()
    
    lazy var termsMenuFooterBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("TERMS & CONDITIONS", for: .normal)
        button.addTarget(self, action: #selector(self.navigateToTermsAndConditions), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: Constants.FONT_FAMILY_SEMIBOLD, size: 12)
        button.setTitleColor(AppColor.SalmonRed, for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    lazy var privacyPolicyFooterBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("PRIVACY POLICY", for: .normal)
        button.addTarget(self, action: #selector(self.navigateToPrivacyPolicy), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: Constants.FONT_FAMILY_SEMIBOLD, size: 12)
        button.setTitleColor(AppColor.SalmonRed, for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    lazy var mainSearchBar: UISearchBar  = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    lazy var bannerView: UIView = {
        let tv = UIView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = AppColor.SalmonRed
        tv.addSubview(bannerTextLbl)
        tv.addSubview(bannerImage)
        return tv
    }()
    
    lazy var bannerTextLbl: UILabel = {
        let bannerLbl = UILabel(frame: CGRect(x: 24, y: 0, width: Constants.screenWidth * 0.6, height: 80))
        bannerLbl.text = "Send Octo Stickers on iMessage now!"
        bannerLbl.font = UIFont(name: Constants.FONT_FAMILY_BOLDITALIC , size: 24)
        bannerLbl.adjustsFontSizeToFitWidth = true
        bannerLbl.minimumScaleFactor = 0.4
        bannerLbl.numberOfLines = 2
        bannerLbl.textColor = UIColor.white
        bannerLbl.textAlignment = .center
        return bannerLbl
    }()

    lazy var bannerImage: UIImageView = {
        let biv = UIImageView(frame: CGRect(x: Constants.screenWidth * 0.65, y: -2, width: 84, height: 85))
        biv.image = #imageLiteral(resourceName: "celebrate").withRenderingMode(.alwaysOriginal)
        return biv
    }()
    
    lazy var titleTextView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.clear
        tv.textColor = AppColor.SalmonRed
        tv.font = UIFont(name: Constants.FONT_FAMILY_BOLD , size: 20)
        tv.text = "ALL STICKERS"
        tv.isSelectable = false
        tv.isUserInteractionEnabled = false
        return tv
    }()
    
    lazy var searchBarFilterButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
        btn.backgroundColor = AppColor.SalmonRed
        btn.layer.borderWidth = 0.12
        btn.clipsToBounds = true
        btn.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        btn.layer.cornerRadius = 25
        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13)
        return btn
    }()
    
    // MARK: - INIT
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.contents = #imageLiteral(resourceName: "bg@100").cgImage
        configureNavigationBar()
        configureSearchBar()
        configureStickerTableView()
        
        self.view.addSubview(mainSearchBar)
        self.view.addSubview(searchBarFilterButton)
        self.view.addSubview(bannerView)
        self.view.addSubview(titleTextView)
        self.view.addSubview(stickerPacksTableView)
        self.view.addSubview(stickyFooterView)
        
        addAutoLayoutConstraints()
        
        if (Reachability.isConnectedToNetwork()){
            print("Internet Connection Available! get stickers")
            self.fetchStickerPacks()
        } else{
            present(CustomAlerts.noInternetConnectionAlert(), animated:true, completion:nil);
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureSearchBarTextField()
        
        if (!Reachability.isConnectedToNetwork()) {
            present(CustomAlerts.noInternetConnectionAlert(), animated:true, completion:nil);
        } else if (stickerPacks.count == 0) {
            self.fetchStickerPacks()
        }
    }
    
    // MARK: - Handlers
    func hasUserAcceptTerms() {
        let hasAgreedToTermsBefore = UserDefaults.standard.bool(forKey: "isTermsAccepted")
        
        if (!hasAgreedToTermsBefore) {
            let vc = TermsAndConditionsController()
            vc.delegate = self
            print("never accepted terms before @HomeController")
            present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        }
    }
    
    @objc func navigateToTermsAndConditions() {
        let vc = TermsAndConditionsController()
        vc.isFromMenu = true
        present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    @objc func navigateToPrivacyPolicy() {
        let vc = PrivacyPolicyController()
        present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        print("search tapped")
        view.endEditing(true)
    }
    
    private func isJailBroken() -> Bool {
        // Check 1 - Read /Write system dir (violation)
        let stringToWrite = "Jailbreak Test"
        do {
            try stringToWrite.write(toFile:"/private/JailbreakTest.txt", atomically:true, encoding:String.Encoding.utf8)
            print("JailBreakTest 1: Failed (system dir (violation)")
            return true
        } catch {
            print("Not writable, device legit")
        }
        
        // Check 2 - App Signerr Identity
        if (Bundle.main.infoDictionary?["SignerIdentity"] as? String) != nil {
            print("JailBreakTest 2: Failed (App Signerr Identity)")
            return true
        }
        #if targetEnvironment(simulator)
        // Do nothing (simulator skip test 3)
        #else
        // Real Device
        if (FileManager.default.fileExists(atPath: "/Applications/Cydia.app")
            || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
            || FileManager.default.fileExists(atPath: "/bin/bash")
            || FileManager.default.fileExists(atPath: "/usr/sbin/sshd")
            || FileManager.default.fileExists(atPath: "/etc/apt")
            || FileManager.default.fileExists(atPath: "/private/var/lib/apt/")
            || UIApplication.shared.canOpenURL(URL(string:"cydia://package/com.example.package")!)) {
            print("JailBreakTest 3: Failed (Illegal Files Detected)")
            return true
        }
        #endif
        return false

    }
    
    private func fetchStickerPacks() {
        self.hasUserAcceptTerms()
        if (isJailBroken()) {
            let alert = UIAlertController(title:"Jailbreak Detected", message:"Your privacy & safety is very important to us, this app cannot be ran on Jail Broken Devices.", preferredStyle: .alert);
            
            //CUSTOM ACTION HANDLER
            let action1 = UIAlertAction(title: "Ok", style: .default, handler: {
                action in
                let vc = JailbreakController()
                
                self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
            })
            alert.addAction(action1);
            present(alert, animated: true, completion: nil)
            return
        } else {
            let hasAgreedToTermsBefore = UserDefaults.standard.bool(forKey: "isTermsAccepted")
            let loadingAlert: UIAlertController = UIAlertController(title: "Loading sticker packs", message: "\n\n", preferredStyle: .alert)
            
                present(loadingAlert, animated: true, completion: nil)
                CustomLoader.instance.setAlpha = 0
            
            if (hasAgreedToTermsBefore) {
                CustomLoader.instance.showLoaderView()
            }
            StickerPackManager.getStickers(stickersCompletionHandler: { data, error in
                do {
                    try StickerPackManager.fetchStickerPacks(fromJSON: data) {
                        stickerPacks in
                            loadingAlert.dismiss(animated: false, completion: {
                                self.navigationController?.navigationBar.alpha = 1.0;
                                
                                if stickerPacks.count > 0 {
                                    self.stickerPacks = stickerPacks
                                    self.stickerPacksTableView.reloadData()
                                }
                            })
                        CustomLoader.instance.hideLoaderView()
                        
                    }
                } catch StickerPackError.fileNotFound {
                    fatalError("sticker_packs.wasticker not found.")
                } catch {
                    fatalError(error.localizedDescription)
                }
            })
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let navigationBar = navigationController?.navigationBar {
            let contentInset: UIEdgeInsets = {
                if #available(iOS 11.0, *) {
                    return scrollView.adjustedContentInset
                } else {
                    return scrollView.contentInset
                }
            }()
            if scrollView.contentOffset.y <= -contentInset.top {
                navigationBar.shadowImage = UIImage()
            } else {
                navigationBar.shadowImage = nil
            }
        }
    }
    
    @objc func addButtonTapped(button: UIButton) {
        if (Interoperability.canSend()) {
            let loadingAlert: UIAlertController = UIAlertController(title: "Sending to WhatsApp", message: "\n\n", preferredStyle: .alert)
            loadingAlert.addSpinner()
            present(loadingAlert, animated: true, completion: nil)
            
            stickerPacks[button.tag].sendToWhatsApp { completed in
                loadingAlert.dismiss(animated: true, completion: nil)
            }
        } else {
            present(CustomAlerts.whatsappNotInstalledAlert(), animated: true, completion: nil)
        }
    }
    
    // MARK: - UI
    func configureStickerTableView() {
        stickerPacksTableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        stickerPacksTableView.backgroundColor = UIColor.clear
        stickerPacksTableView.tableFooterView = UIView(frame: .zero)
        stickerPacksTableView.separatorStyle = .none
        stickerPacksTableView.delegate = self
        stickerPacksTableView.dataSource = self
        stickerPacksTableView.register(UINib(nibName: "StickerPackTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        stickerPacksTableView.translatesAutoresizingMaskIntoConstraints = false
        stickerPacksTableView.showsVerticalScrollIndicator = false
    }
    
    func configureSearchBar() {
        mainSearchBar.delegate = self
        mainSearchBar.returnKeyType = .done
        mainSearchBar.isTranslucent = false
        mainSearchBar.backgroundImage = UIImage()
        mainSearchBar.clipsToBounds = true
        mainSearchBar.layer.cornerRadius = 25
        mainSearchBar.layer.borderWidth = 0.12
    }
    
    func configureSearchBarTextField() {
        searchTextField = mainSearchBar.subviews[0].subviews.last as! UITextField
        
        let image:UIImage = UIImage(named: "search")!
        //        let imageView:UIImageView = UIImageView.init(image: image)
        //        imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        searchTextField.leftView = nil
        searchTextField.textColor = AppColor.SalmonRed
        searchTextField.placeholder = "Search stickers"
        searchTextField.textAlignment = NSTextAlignment.left
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(self.dismissKeyboard), for: .touchUpInside)
        searchTextField.rightView = button
        searchTextField.rightViewMode = UITextFieldViewMode.always
    }
    
    func configureNavigationBar() {
        _ = #imageLiteral(resourceName: "cimblogowhite").withRenderingMode(.alwaysOriginal)
        createNavigationButton(image: #imageLiteral(resourceName: "cimblogowhite"), side: "right", width: 75, height: 20)
    }
    
    func configureNavigationBarRight() {
           _ = #imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal)
           createNavigationButton(image: #imageLiteral(resourceName: "cimblogowhite"), side: "left", width: 75, height: 20)
       }
    
    func createNavigationButton(image: UIImage, side: String, width: CGFloat, height: CGFloat) {
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        menuBtn.setImage(image, for: .normal)
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        
        if #available(iOS 9.0, *) {
            let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: width)
            currWidth?.isActive = true
            let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: height)
            currHeight?.isActive = true
        }
        
        if (side == "left") {
            self.navigationItem.leftBarButtonItem = menuBarItem
        } else if (side == "right") {
            self.navigationItem.rightBarButtonItem = menuBarItem
        }
    }
    
    func addAutoLayoutConstraints() {
        let margins = view.layoutMarginsGuide
        
        var searchBarTopAnchor: CGFloat
        var bannerViewTopAnchor: CGFloat
        var titleTextTopAnchor: CGFloat
        var stickerTableTopAnchor: CGFloat
        var stickyFooterViewBottomAnchor: CGFloat
        var footerSpacing: CGFloat
        var footerItemHeight: CGFloat
        
        // iPhoneX & above Constraints
        if (!UIDevice.current.hasHomeButton) {
            searchBarTopAnchor = Constants.screenHeight * 0.14
        } else {
            searchBarTopAnchor = 70
        }
        
        // iPhone5S / iPhoneSE Constraints
        if (UIDevice.current.type == UIDevice.PhoneType.iPhone_5_5S_5C) {
            titleTextTopAnchor = -4
            bannerViewTopAnchor = 4
            stickerTableTopAnchor = 0
            stickyFooterViewBottomAnchor = -2
            footerSpacing = 2
            footerItemHeight = 10
        } else {
            titleTextTopAnchor = 32
            bannerViewTopAnchor = 24
            stickerTableTopAnchor = 16
            stickyFooterViewBottomAnchor = -16
            footerSpacing = 4
            footerItemHeight = 14
        }
        mainSearchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: searchBarTopAnchor).isActive = true
        mainSearchBar.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        mainSearchBar.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        bannerView.topAnchor.constraint(equalTo: mainSearchBar.bottomAnchor, constant: bannerViewTopAnchor).isActive = true
        bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bannerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        bannerView.addFullScreenBackgroundImage(withImageName: "iMessage_banner_bg")

        titleTextView.topAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: titleTextTopAnchor).isActive = true
        titleTextView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 2).isActive = true
        titleTextView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        titleTextView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        stickerPacksTableView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: stickerTableTopAnchor).isActive = true
        stickerPacksTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        stickerPacksTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -4).isActive = true
        stickerPacksTableView.bottomAnchor.constraint(equalTo: stickyFooterView.topAnchor, constant: -12).isActive = true
        
        footerAppVersionLbl.heightAnchor.constraint(equalToConstant: footerItemHeight).isActive = true
        footerCopyrightLbl.heightAnchor.constraint(equalToConstant: footerItemHeight).isActive = true
        termsMenuFooterBtn.heightAnchor.constraint(equalToConstant: footerItemHeight).isActive = true
        privacyPolicyFooterBtn.heightAnchor.constraint(equalToConstant: footerItemHeight).isActive = true
    
        stickyFooterView.spacing = footerSpacing
        stickyFooterView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stickyFooterView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: stickyFooterViewBottomAnchor).isActive = true
    }
}

// MARK: - Extensions
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        
        print("selected Index is", selectedIndex!)
        let vc = StickerPackRowClickedController()
        
        if (isSearching) {
            vc.stickerPack = filteredArray[indexPath.row]
        } else {
            vc.stickerPack = stickerPacks[indexPath.row]
        }
        self.navigationController?.pushViewController(vc, animated: true)
        //present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isSearching) {
            return filteredArray.count
        } else {
            return stickerPacks.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Layout.stickerTableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? StickerPackTableViewCell else { return UITableViewCell() }
        
        if (isSearching) {
            cell.stickerPack = filteredArray[indexPath.row]
        } else {
            cell.stickerPack = stickerPacks[indexPath.row]
        }
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        
        
        let offset = titleTextView.text.height(withConstrainedWidth: titleTextView.frame.width, font: UIFont.systemFont(ofSize: 20))
        
        // + Button
        let addButton: UIButton = UIButton()
        let resizedImg = #imageLiteral(resourceName: "download").resizeImage(targetSize: CGSize(width: 24, height: 24))
        let original = resizedImg.withRenderingMode(.alwaysOriginal)
        addButton.setImage(original, for: .normal)
        addButton.tag = indexPath.row
        addButton.addTarget(self, action: #selector(addButtonTapped(button:)), for: .touchUpInside)
        cell.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        addButton.centerYAnchor.constraint(equalTo: cell.centerYAnchor, constant: 12.5).isActive = true
        addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        addButton.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: offset).isActive = true
        return cell
    }
}

extension HomeController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if mainSearchBar.text == nil || mainSearchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            stickerPacksTableView.reloadData()
        } else {
            isSearching = true
            filteredArray = stickerPacks.filter({$0.name.range(of: mainSearchBar.text!, options: .caseInsensitive) != nil })
            stickerPacksTableView.reloadData()
        }
    }
}

extension HomeController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        mainSearchBar.resignFirstResponder()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        print("just press enter")
    }
}
