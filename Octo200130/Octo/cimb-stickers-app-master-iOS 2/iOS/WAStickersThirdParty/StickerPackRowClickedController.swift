//
//  StickerRowClickedController.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 4/9/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import Foundation

class StickerPackRowClickedController: UIViewController {
    // MARK: - Properties
    private let cellId = "cellId"
    private let interimSpacing: CGFloat = 10
    private let numberOfItemsPerRow: CGFloat = 3
    
    var stickerPack:StickerPack?
    var stickers:[Sticker]?
    
    let descriptionView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.white
        v.layer.shadowColor = AppColor.shadowGray.cgColor
        v.layer.shadowOpacity = 1
        v.layer.shadowOffset = CGSize.zero
        v.layer.shadowRadius = 5
        return v
    }()
    
    let bannerImage:UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var stickerDescriptionLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.FONT_FAMILY , size: 16)
        
        let stringValue = "Feeling playful? Happy? Sleepy? Say it all with Octo Stickers!"
        let attrString = NSMutableAttributedString(string: stringValue)
        var style = NSMutableParagraphStyle()
        style.lineSpacing = 4
        style.minimumLineHeight = 16
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSRange(location: 0, length: stringValue.count))
        label.attributedText = attrString
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    var stickerCountAndSizeLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "9 STICKERS | 500 KB"
        label.font = UIFont(name: Constants.FONT_FAMILY_SEMIBOLD , size: 14)
        label.textAlignment = .left
        return label
    }()
    
    let newCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        collection.layer.backgroundColor = UIColor.clear.cgColor
        collection.showsHorizontalScrollIndicator = true
        collection.indicatorStyle = .black
        collection.scrollIndicatorInsets = UIEdgeInsetsMake(0, Constants.screenWidth * 0.3, 0, Constants.screenWidth * 0.3)
        return collection
    }()
    
    let addToWhatsappBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = AppColor.SalmonRed
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.clipsToBounds = false
        btn.layer.cornerRadius = 25
        btn.titleLabel?.font = UIFont(name: Constants.FONT_FAMILY_BOLD, size: 14)
        btn.setTitle("ADD TO WHATSAPP", for: .normal)
        return btn
    }()
    
    
    // MARK: - Init
    override func viewDidLayoutSubviews() {
        newCollection.flashScrollIndicators()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.addSubview(bannerImage)
        view.addSubview(descriptionView)
        view.addSubview(stickerDescriptionLbl)
        view.addSubview(stickerCountAndSizeLbl)
        view.addSubview(newCollection)
        view.addSubview(addToWhatsappBtn)
        self.tabBarController?.tabBar.isHidden = false
        
        addToWhatsappBtn.addTarget(self, action: #selector(self.addToWhatsappTapped), for: .touchUpInside)
        
        configureCollection()
        addAutoLayoutConstraints()
        
        stickers = stickerPack?.stickers

        if let count = stickers?.count, let size = stickerPack?.formattedSize, let title = stickerPack?.name {
            stickerCountAndSizeLbl.text = "\(count) STICKERS  |  \(size)"
            self.title = title.uppercased()
        }
        
        if let stickers = stickers {
            let image = stickers[0].imageData.image
            bannerImage.image = image
        }
    }
    // MARK: - HANDLERS
    @objc func addToWhatsappTapped() {
        if (Interoperability.canSend()) {
            stickerPack?.sendToWhatsApp(completionHandler: { (Bool) in
                print("sending complete!")
            })
        } else {
            present(CustomAlerts.whatsappNotInstalledAlert(), animated: true, completion: nil)
        }
    }
    
    // MARK: - UI
    func configureUI() {
        addCloseButton(presentationStyle: PresentationStyle.Push)
        view.addFullScreenBackgroundImage(withImageName: "bg@100.png", contentMode: .scaleAspectFit)
    }
    
    func configureCollection() {
        newCollection.delegate = self
        newCollection.dataSource = self
        newCollection.register(StickerRowClickedCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func addAutoLayoutConstraints() {
        let margins = view.layoutMarginsGuide
        
        var stickerDescriptionTopAnchor: CGFloat
        var stickerCountTopAnchor: CGFloat
        var whatsappBtnBottomAnchor: CGFloat

        // iPhoneX & above Constraints
        if (UIDevice.current.type == UIDevice.PhoneType.iPhone_5_5S_5C) {
            stickerDescriptionTopAnchor = Constants.screenHeight * 0.01
            stickerCountTopAnchor = 8
            whatsappBtnBottomAnchor = -Constants.screenHeight * 0.1
        } else {
            stickerDescriptionTopAnchor = Constants.screenHeight * 0.05
            stickerCountTopAnchor = 24
            whatsappBtnBottomAnchor = -Constants.screenHeight * 0.12
        }
        
        descriptionView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 4).isActive = true
        descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        descriptionView.heightAnchor.constraint(equalToConstant: Constants.screenHeight * 0.25).isActive = true
        
        bannerImage.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: Constants.screenHeight * 0.03).isActive = true
        bannerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        bannerImage.widthAnchor.constraint(equalToConstant: Constants.screenHeight * 0.18).isActive = true
        bannerImage.heightAnchor.constraint(equalToConstant: Constants.screenHeight * 0.18).isActive = true
        
        stickerDescriptionLbl.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: stickerDescriptionTopAnchor).isActive = true
        stickerDescriptionLbl.leadingAnchor.constraint(equalTo: bannerImage.trailingAnchor, constant: 12).isActive = true
        stickerDescriptionLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        stickerCountAndSizeLbl.topAnchor.constraint(equalTo:  stickerDescriptionLbl.bottomAnchor, constant: stickerCountTopAnchor).isActive = true
        stickerCountAndSizeLbl.leadingAnchor.constraint(equalTo: stickerDescriptionLbl.leadingAnchor).isActive = true
        stickerCountAndSizeLbl.trailingAnchor.constraint(equalTo: stickerDescriptionLbl.trailingAnchor).isActive = true
        
        descriptionView.addSubview(bannerImage)
        descriptionView.addSubview(stickerDescriptionLbl)
        descriptionView.addSubview(stickerCountAndSizeLbl)
        
        newCollection.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: Constants.screenHeight * 0.06).isActive = true
        newCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newCollection.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65).isActive = true
        newCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.screenWidth * 0.02).isActive = true
        newCollection.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.98).isActive = true
        
        addToWhatsappBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: whatsappBtnBottomAnchor).isActive = true
        addToWhatsappBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addToWhatsappBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addToWhatsappBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
    }
}

extension StickerPackRowClickedController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return stickers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newCollection.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StickerRowClickedCell
        cell.sticker = stickers![indexPath.row]
        //cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.frame.width * 0.5
        let stickerWidth = collectionWidth
        return CGSize(width: stickerWidth, height: stickerWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item \(indexPath.row) selected!")
    }
    
}
