//
// Copyright (c) WhatsApp Inc. and its affiliates.
// All rights reserved.
//
// This source code is licensed under the BSD-style license found in the
// LICENSE file in the root directory of this source tree.
//

import UIKit

final class StickerPackTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let interimSpacing: CGFloat = 6
    private let numberOfItemsPerRow: CGFloat = 4
    
    @IBOutlet private weak var stickerPackTitleLabel: UILabel!
    @IBOutlet private weak var stickerPackDataSizeLabel: UILabel!
    @IBOutlet private weak var stickerPackAdditionalCountLabel: UILabel!
    @IBOutlet private weak var stickerPackCollectionView: UICollectionView!
    
    var stickerPack: StickerPack? {
        didSet {
            stickerPackTitle = stickerPack?.name
            stickerPackDataSize = stickerPack?.formattedSize
            // stickerPackSecondaryInfo = stickerPack?.publisher
            if let stickerPackCount = stickerPack?.stickers.count {
                if stickerPackCount != Int(numberOfItemsPerRow) {
                    stickerPackExtraCount = String(format: "+%i", stickerPackCount - Int(numberOfItemsPerRow))
                }
            }
            stickerPackCollectionView.reloadData()
        }
    }
    
    var stickerPackTitle: String? {
        get {
            return stickerPackTitleLabel.text
        }
        set {
            stickerPackTitleLabel.text = newValue
        }
    }
    
    var stickerPackDataSize: String? {
        get {
            return stickerPackDataSizeLabel.text!
        }
        set {
            stickerPackDataSizeLabel.text = newValue
        }
    }
    
    var stickerPackExtraCount: String? {
        get {
            return stickerPackAdditionalCountLabel.text!
        }
        set {
            stickerPackAdditionalCountLabel.text = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stickerPackCollectionView.dataSource = self
        stickerPackCollectionView.delegate = self
        stickerPackCollectionView.register(StickerCell.self, forCellWithReuseIdentifier: "StickerCell")
        stickerPackCollectionView.layer.borderWidth = 0.15
        setDesignStyles()
    }
    
    // MARK: Collectionview
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interimSpacing;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalInsets:CGFloat = 48 + (numberOfItemsPerRow * interimSpacing)
        let collectionWidth = (self.viewWithTag(10)?.frame.size.width)! - totalInsets
        let stickerWidth = (collectionWidth - 2.0 * interimSpacing) / numberOfItemsPerRow
        let heightOffset = (self.viewWithTag(10)?.frame.size.height)! - stickerWidth
        
        return CGSize(width: stickerWidth, height: stickerWidth + heightOffset)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let stickerPack = stickerPack else {
            return 0
        }
        return stickerPack.stickers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StickerCell", for: indexPath) as! StickerCell
        if let sticker = stickerPack?.stickers[indexPath.row] {
            cell.sticker = sticker
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 40)
    }
    
    
    func setDesignStyles() {
        stickerPackTitleLabel.textColor = AppColor.SalmonRed
        stickerPackTitleLabel.font = UIFont(name: Constants.FONT_FAMILY_BOLD , size: 16)
        
        stickerPackDataSizeLabel.textColor = AppColor.SalmonRed
        stickerPackDataSizeLabel.font = UIFont(name: Constants.FONT_FAMILY_BOLD , size: 12)
        stickerPackAdditionalCountLabel.textColor = AppColor.SalmonRedDark
        
        
        self.stickerPackCollectionView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        
        self.stickerPackCollectionView.layer.shadowColor = AppColor.shadowGray.cgColor
        self.stickerPackCollectionView.layer.masksToBounds = false
        self.stickerPackCollectionView.clipsToBounds = false
        self.stickerPackCollectionView.layer.shadowOpacity = 1
        self.stickerPackCollectionView.layer.shadowRadius = 0.5
        self.stickerPackCollectionView.layer.cornerRadius = 20
        self.stickerPackCollectionView.layer.shadowOffset = CGSize.init(width: 0, height: 4)
    }
}
