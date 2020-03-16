//
//  StickerRowClickedCell.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 4/9/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

class StickerRowClickedCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    var sticker: Sticker? {
        willSet {
            if newValue !== sticker {
                imageView.image = nil
            }
        }
        didSet {
            if oldValue !== sticker {
                if let currentSticker = sticker {
                    StickerPackManager.queue.async {
                        let image = currentSticker.imageData.image(withSize: CGSize(width: 256, height: 256))
                        DispatchQueue.main.async {
                            if let sticker = self.sticker, currentSticker === sticker {
                                self.imageView.image = image
                            }
                        }
                    }
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        setupLayout()
    }
    
    func setupLayout() {
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 192).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 192).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)has not been implemented")
    }
}
