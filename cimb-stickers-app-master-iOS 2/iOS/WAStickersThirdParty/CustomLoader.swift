import Foundation
import UIKit

class CustomLoader: UIView {
    
    static let instance = CustomLoader()
    
    var viewColor: UIColor = .black
    var setAlpha: CGFloat = 0.5
    var gifName: String = ""
    
    lazy var transparentView: UIView = {
        let transparentView = UIView()
        transparentView.backgroundColor = viewColor.withAlphaComponent(setAlpha)
        transparentView.isUserInteractionEnabled = false
        transparentView.translatesAutoresizingMaskIntoConstraints = false
        return transparentView
    }()
    
    lazy var gifImage: UIImageView = {
        var gifImage = UIImageView()
        gifImage.translatesAutoresizingMaskIntoConstraints = false
        gifImage.contentMode = .scaleAspectFit
        gifImage.isUserInteractionEnabled = false
        gifImage.loadGif(name: "Loader")
        return gifImage
    }()
    
    func addAutoLayout() {
        transparentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        transparentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        
        gifImage.centerYAnchor.constraint(equalTo: transparentView.centerYAnchor, constant: 12).isActive = true
        gifImage.centerXAnchor.constraint(equalTo: transparentView.centerXAnchor).isActive = true
        gifImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        gifImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func showLoaderView() {
        self.addSubview(self.transparentView)
        self.transparentView.addSubview(self.gifImage)
        
        self.transparentView.bringSubview(toFront: self.gifImage)
        UIApplication.shared.keyWindow?.addSubview(transparentView)
        addAutoLayout()
        
    }
    
    func hideLoaderView() {
        self.transparentView.removeFromSuperview()
    }
    
}
