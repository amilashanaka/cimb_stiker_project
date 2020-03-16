//
//  HomeVC.swift
//  WAStickersThirdParty
//
//  Created by AXAT Mac mini 3 (2019) on 16/12/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import UIKit
import Foundation
import YPImagePicker


class HomeVC: UIViewController,SideFadeInOutDelegate,CurveSideInDelegate,isDismissedFromTerms{
    func pass(data: String) {
         StickerPackManager.run(after: 1) {
                   if (data == "Terms") {
                       print("Initialized From Terms")
                      // self.tabBarController?.selectedIndex = 1
                   }
               }
    }
    
    func hideCurveSideInMenu() {
         self.menuView.isHidden = true
    }
    
    func hideSideFadeInOutMenu() {
        self.menuView.isHidden = true
    }
    

    @IBOutlet weak var octoLensesImage: UIImageView!
    
    @IBOutlet weak var octoStickerImage: UIImageView!
    @IBOutlet weak var btnCoverScreen: UIButton!
     
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var homeView: UIView!
    
    @IBOutlet weak var btnHome: UIButton!
    
    @IBOutlet weak var octoLensesView: UIView!
    
  
    @IBOutlet weak var octoStickersView: UIView!
    
    @IBOutlet weak var tutorialView: UIView!
    
    @IBOutlet weak var btnTutorial: UIButton!
    
    @IBOutlet weak var faqView: UIView!
    
    @IBOutlet weak var suggestionView: UIView!
    
    @IBOutlet weak var OctoViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var octoView: UIView!
    @IBOutlet weak var octoStackView: UIStackView!
    
    
    // Photo Edit Picker View
    
    @IBOutlet weak var backViewPhotoSticker: UIView!
    
    @IBOutlet weak var PhotoEditImage: UIImageView!
    
    @IBOutlet weak var btnSave: UIButton!
   
    @IBOutlet weak var btnDone: UIButton!
    
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnCloseImageSticker: UIButton!
    
    // Stickers
    
    @IBOutlet weak var backViewStickers: UIView!
    @IBOutlet weak var CollectionViewLatestStickers: UICollectionView!
    
    @IBOutlet weak var CollectionViewLatestGif: UICollectionView!
    
    @IBOutlet weak var CollectionViewStickers: UICollectionView!
    
    
    // TYPFACES OUTLETS
    
    @IBOutlet weak var backViewTypefaces: UIView!
    
    @IBOutlet weak var CollectionViewLatestTypefaces: UICollectionView!
    @IBOutlet weak var CollectionViewAllTypeFaces: UICollectionView!
    
    // FRAMES
    
    @IBOutlet weak var backViewFrames: UIView!
    
    @IBOutlet weak var CollectionViewLatestFrames: UICollectionView!
    
    @IBOutlet weak var CollectionViewAllFrames: UICollectionView!
    
    
    
     // Photo Edit Picker View
    
    @IBOutlet weak var backViewSticker: UIView!
    @IBOutlet weak var stickerView: UIView!
   
    @IBOutlet weak var btnCloseStickerView: UIButton!
    
    @IBOutlet weak var btnSticker: UIButton!
    
    @IBOutlet weak var btnTypeFace: UIButton!
    
    @IBOutlet weak var btnFrames: UIButton!
    
    
    
    @IBAction func btnOctoLenses(_ sender: Any) {
      }
    @IBAction func btnhome(_ sender: Any) {
    }
    var delegate: HomeControllerDelegate?
    var isTutorial : Bool = false
    
    var picker = YPImagePicker()
    var config = YPImagePickerConfiguration()
    var selectedImage = UIImage()
    
    var Stickers = [String]()
    var LatestStickers = [String]()
    var LatestGif = [String]()
    
    
  //  var testImage = UIImageView()
    
    private var _selectedStickerView:StickerView?
       var selectedStickerView:StickerView? {
           get {
               return _selectedStickerView
           }
           set {
               // if other sticker choosed then resign the handler
               if _selectedStickerView != newValue {
                   if let selectedStickerView = _selectedStickerView {
                       selectedStickerView.showEditingHandlers = false
                   }
                   _selectedStickerView = newValue
               }
               // assign handler to new sticker added
               if let selectedStickerView = _selectedStickerView {
                   selectedStickerView.showEditingHandlers = true
                   selectedStickerView.superview?.bringSubview(toFront: selectedStickerView)
               }
           }
       }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpMenuItems()
        self.menuView.isHidden = true
        
       customize()
       // self.btnCoverScreen.isHidden = true
        self.btnCoverScreen.alpha = 0.0
        self.OctoViewHeight.constant = 0
        self.octoView.isHidden = true
     let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.layer.add(transition, forKey: nil)
        self.view.addSubview(menuView)
     
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ShowOctoStickers(sender:)))
        self.octoLensesImage.addGestureRecognizer(tapGesture)
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(ShowOctoStickers(sender:)))
        self.octoStickerImage.addGestureRecognizer(tapGesture1)
          
   
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         self.navigationController?.navigationBar.isHidden = false
    }
    

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
    @IBAction func actionOnOctoLensesBtn(_ sender: Any) {
        picker.modalPresentationStyle = .overFullScreen
        present(picker, animated: true, completion: nil)
       
        self.selectedStickerView?.isHidden = true
      //  self.menuView.isHidden = true
        self.btnCoverScreen.isHidden = true
        self.octoStackView.isHidden = true
         self.navigationController?.navigationBar.isHidden = true
        
    }
    
    @IBAction func actionOnOctoStickersBtn(_ sender: Any) {
        
        let homeController =  HomeController()
        self.navigationController?.pushViewController(homeController, animated: true)
    }
    
    
    @objc func ShowOctoStickers(sender: UITapGestureRecognizer) {
        print("tap")
         let homeController =  HomeController()
         self.navigationController?.pushViewController(homeController, animated: true)
    }
    
    func setUpMenuItems() {
        let menu = UIBarButtonItem(image: UIImage(named: "ic-menu")?.withRenderingMode(.alwaysOriginal),
                                            landscapeImagePhone: nil,
                                            style: .plain,
                                            target: self,
                                            action: #selector(self.menuAction(sender:)))
        let Rightmenu = UIBarButtonItem(image: UIImage(named: "cimblogowhite")?.withRenderingMode(.alwaysOriginal),
                                                   landscapeImagePhone: nil,
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(self.rightMenu(sender:)))
           
        self.navigationItem.leftBarButtonItems = [menu]
        self.navigationItem.rightBarButtonItems = [Rightmenu]
        
    }
    @IBAction func btnCoverScreenAction(_ sender: UIButton) {
        
          self.hideSideFadeInOutMenu()
        self.menuView.isHidden = true
        self.btnCoverScreen.alpha = 0.0
        self.navigationController?.navigationBar.isHidden = false
        
       }

    @IBAction func actionOnTutorial(_ sender: Any) {
        
        if isTutorial {

            isTutorial = false
            self.OctoViewHeight.constant = 0
            self.octoView.isHidden = true
        }
        else {
            isTutorial = true
        self.OctoViewHeight.constant = 68
            self.octoView.isHidden = false
        }
    }
    
    
    @IBAction func actionOnTermsAndCond(_ sender: Any) {
        
        let vc = TermsAndConditionsController()
              vc.isFromMenu = true
                  present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
              vc.acceptBtn.isHidden = true
                    vc.titleTextLabel.isHidden = true
              delegate?.handleMenuToggle(forMenuOption: nil)
//
    }
   
    
    @IBAction func actionOnPrivacyPolicy(_ sender: Any) {
        
        print("Privacy Policy")
               let vc = PrivacyPolicyController()
               present(UINavigationController(rootViewController: vc), animated: true, completion: nil)

               delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
      @objc func rightMenu( sender : UIBarButtonItem){
        
    }
    
    @objc func menuAction( sender : UIBarButtonItem){
         
        self.navigationController?.navigationBar.isHidden = true
      // self.menuView.alpha = 0.0
        
      //  let viewMenuBack : UIView = view.subviews.last!
        self.menuView.isHidden = false
                 UIView.animate(withDuration: 0.3, animations: { () -> Void in
                   // self.menuView.frame  = viewMenuBack.frame
                  //  self.menuView.frame = CGRect(x:0, y:0, width: UIScreen.main.bounds.size.width/2, height: UIScreen.main.bounds.size.height)
                   self.menuView.isHidden = false
                    self.menuView.layoutIfNeeded()
                     
                     }, completion: { (finished) -> Void in
                       //  viewMenuBack.removeFromSuperview()
                        self.showMenu()
                 })
   
          }
    
    
    
    
        
       func diplace(){
//           self.profileImgView.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
           self.homeView.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
           self.octoLensesView.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
           self.octoStickersView.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
          self.tutorialView.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
          self.faqView.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
          self.suggestionView.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)

           self.btnCoverScreen.alpha = 0.0
           self.menuView.alpha = 0.0
       }
       

    func showMenu()  {
           self.diplace()
       
//           UIView.animate(withDuration: 0.7, delay: 0.4, options: .curveEaseOut, animations: {
//               self.homeView.transform = .identity
//               self.suggestionView.transform = .identity
//           })
//
//          UIView.animate(withDuration: 0.7, delay: 0.3, options: .curveEaseOut, animations: {
//              self.octoLensesView.transform = .identity
//               self.faqView.transform = .identity
//           })
//
//          UIView.animate(withDuration: 0.7, delay: 0.2, options: .curveEaseOut, animations: {
//               self.octoStickersView.transform = .identity
//           })
//
//           UIView.animate(withDuration: 0.7, delay: 0.1, options: .curveEaseOut, animations: {
//              self.tutorialView.transform = .identity
//          })
    
//
//           UIView.animateKeyframes(withDuration: 0.4, delay: 0.1, options: .calculationModeDiscrete, animations: {
//               self.btnCoverScreen.alpha = 1.0
//               self.menuView.alpha = 1.0
//           })
        
        
        // curve side in
        
        UIView.animate(withDuration: 0.7, delay: 0.35, options: .curveEaseOut, animations: {
            self.homeView.transform = .identity
        })

        UIView.animate(withDuration: 0.7, delay: 0.3, options: .curveEaseOut, animations: {
            self.octoStickersView.transform = .identity
        })

        UIView.animate(withDuration: 0.7, delay: 0.25, options: .curveEaseOut, animations: {
            self.octoLensesView.transform = .identity
        })
        
        UIView.animate(withDuration: 0.7, delay: 0.2, options: .curveEaseOut, animations: {
            self.tutorialView.transform = .identity
        })
        
        UIView.animate(withDuration: 0.7, delay: 0.15, options: .curveEaseOut, animations: {
            self.faqView.transform = .identity
        })
        
        UIView.animate(withDuration: 0.7, delay: 0.1, options: .curveEaseOut, animations: {
            self.suggestionView.transform = .identity
        })
          UIView.animateKeyframes(withDuration: 0.4, delay: 0.1, options: .calculationModeDiscrete, animations: {
                       self.btnCoverScreen.alpha = 1.0
                       self.menuView.alpha = 1.0
                   })
       }
    
    func hideMenu(completion : @escaping () -> Void)  {
        
        UIView.animate(withDuration: 0.7, delay: 0.05, options: .curveEaseOut, animations: {
                  self.homeView.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
              })
              
              UIView.animate(withDuration: 0.7, delay: 0.1, options: .curveEaseOut, animations: {
                  self.octoStickersView.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
              })
              
              UIView.animate(withDuration: 0.7, delay: 0.15, options: .curveEaseOut, animations: {
                  self.octoLensesView.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
                  
              })
              
              UIView.animate(withDuration: 0.7, delay: 0.2, options: .curveEaseOut, animations: {
                  self.tutorialView.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
              })
              
              UIView.animate(withDuration: 0.7, delay: 0.25, options: .curveEaseOut, animations: {
                  self.faqView.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
              })
              
              UIView.animate(withDuration: 0.7, delay: 0.30, options: .curveEaseOut, animations: {
                  self.suggestionView.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
              })
              
            
              
        
        
//
//        UIView.animate(withDuration: 0.7, delay: 0.1, options: .curveEaseOut, animations: {
//            self.homeView.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
//            self.suggestionView.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
//    })
//
//           UIView.animate(withDuration: 0.7, delay: 0.2, options: .curveEaseOut, animations: {
//              self.octoLensesView.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
//               self.faqView.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
//           })
//
//           UIView.animate(withDuration: 0.7, delay: 0.3, options: .curveEaseOut, animations: {
//               self.octoStickersView.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
//               self.tutorialView.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
//           })

//           UIView.animate(withDuration: 0.7, delay: 0.4, options: .curveEaseOut, animations: {
//              self.btnFlash.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
//           })
           
           UIView.animateKeyframes(withDuration: 0.4, delay: 0.3, options: .calculationModeDiscrete, animations: {
               self.btnCoverScreen.alpha = 0.0
               self.menuView.alpha = 0.0
               
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
                   completion()
               })
           })
       }
   
    // MARK: - Navigation

   
    @IBAction func actionOnHomeMenu(_ sender: Any) {
        self.menuView.isHidden = true
        self.btnCoverScreen.alpha = 0.0
         self.navigationController?.navigationBar.isHidden = false
        
//           let Home = HomeVC()
//              self.navigationController?.pushViewController(Home, animated: true)
        
    }
    
    @IBAction func actionOnOctoLenses(_ sender: Any) {
         self.menuView.isHidden = true
        self.btnCoverScreen.alpha = 0.0
        
         self.navigationController?.navigationBar.isHidden = false
        
    }
    
    @IBAction func actionOnOctoStickers(_ sender: Any) {
         self.menuView.isHidden = true
        self.btnCoverScreen.alpha = 0.0
         self.navigationController?.navigationBar.isHidden = false
      
    }
    @IBAction func actionOnTutorialLenses(_ sender: Any) {
        let TutorialVC = TutorialLensesPageVC()
        self.navigationController?.pushViewController(TutorialVC, animated: true)
        
    }
    @IBAction func actionOnTutorialStickers(_ sender: Any) {
        let HowToVC = HowToController()
        self.navigationController?.pushViewController(HowToVC, animated: true)
        
        
    }
    
    @IBAction func actionOnFaqs(_ sender: Any) {
        // let faqController = UINavigationController(rootViewController: FaqsController())
        // present(UINavigationController(rootViewController: faqController), animated: true, completion: nil)
          let faqController = FaqsController()
//
////                termsVC.acceptBtn.isHidden = true
////                termsVC.titleTextLabel.isHidden = true
        self.navigationController?.pushViewController(faqController, animated: true)
                
    }
    
    @IBAction func actionOnSugestion(_ sender: Any) {
          let suggestionController = SuggestionsController()
         self.navigationController?.pushViewController(suggestionController, animated: true)
    }
    
    
    
    
       // #MARK: - ACTION ON BUTTONS FROM STICKER VIEW
       @IBAction func actionOnbtnCloseStickerView(_ sender: Any) {
           
//           self.backViewPhotoSticker.isHidden = true
//          // self.menuView.isHidden = false
//           self.btnCoverScreen.isHidden = false
//           self.octoStackView.isHidden = false
        self.backViewPhotoSticker.isHidden = true
        // self.menuView.isHidden = false
         self.btnCoverScreen.isHidden = false
         self.octoStackView.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
//        let ShareStickerVC : HomeVC = UIStoryboard(name: "main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//        self.backViewPhotoSticker.isHidden = true
//                 // self.menuView.isHidden = false
//                  self.btnCoverScreen.isHidden = false
//                  self.octoStackView.isHidden = false
//        self.navigationController?.navigationBar.isHidden = false
//
//        self.present(ShareStickerVC, animated: true, completion: nil)
           
          // self.dismiss(animated: true, completion: nil)
           
       }
       
       @IBAction func actionOnSaveImage(_ sender: Any) {
       
        
//        selectedStickerView?.showEditingHandlers = false
//
//              if self.PhotoEditImage.subviews.filter({$0.tag == 999}).count > 0 {
//
//                   if let image = mergeImages(imageView: PhotoEditImage){
//                       UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
//                   }else{
//                       print("Image not found !!")
//                   }
//               }else{
//                   UIAlertController.showAlertWithOkButton(self, aStrMessage: "No Sticker is available.", completion: nil)
//               }
       }
    
    
    //MARK: - Add image to Library
      @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
          if let error = error {
              // we got back an error!
              UIAlertController.showAlertWithOkButton(self, aStrMessage: "Save error", completion: nil)
          } else {
              UIAlertController.showAlertWithOkButton(self, aStrMessage: "Your image has been saved to your photos.", completion: nil)
          }
      }
    
    func mergeImages(imageView: UIImageView) -> UIImage? {
              UIGraphicsBeginImageContextWithOptions(imageView.frame.size, false, 0.0)
                      imageView.superview!.layer.render(in: UIGraphicsGetCurrentContext()!)
                      let image = UIGraphicsGetImageFromCurrentImageContext()
                      UIGraphicsEndImageContext()
                      return image
         }
       
       @IBAction func actionOnEditBtn(_ sender: Any) {
        
        self.backViewSticker.isHidden = false
       }
       
       @IBAction func actionOnDoneBtn(_ sender: Any) {
        
        selectedStickerView?.showEditingHandlers = false
//              if self.PhotoEditImage.subviews.filter({$0.tag == 999}).count > 0 {
//                  if let image = mergeImages(imageView: PhotoEditImage){
//                    // share(shareText: "", shareImage: image)
//                  }else{
//                      print("Image not found !!")
//                  }
//              }else{
//                  UIAlertController.showAlertWithOkButton(self, aStrMessage: "No Sticker is available.", completion: nil)
//              }
//
         let ShareStickerVC : ShareStickerVC = UIStoryboard(name: "main", bundle: nil).instantiateViewController(withIdentifier: "ShareStickerVC") as! ShareStickerVC

        //ShareStickerVC.receivedImage = self.PhotoEditImage.image
        if self.PhotoEditImage.subviews.filter({$0.tag == 999}).count > 0 {

              if let Shareimage = mergeImages(imageView: PhotoEditImage){
                            // share(shareText: "", shareImage: Shareimage)
                ShareStickerVC.receivedImage = Shareimage
                }else{
                             print("Image not found !!")
                }
            }else{
                    UIAlertController.showAlertWithOkButton(self, aStrMessage: "No Sticker is available.", completion: nil)
         }
        
        self.present(ShareStickerVC, animated: true, completion: nil)
        
        
           
       }
    
    
    func share(shareText:String?,shareImage:UIImage?){
           
           var objectsToShare = [AnyObject]()
           
           if let shareTextObj = shareText{
               objectsToShare.append(shareTextObj as AnyObject)
           }
           
           if let shareImageObj = shareImage{
               objectsToShare.append(shareImageObj)
           }
           
           if shareText != nil || shareImage != nil{
               let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
               activityViewController.popoverPresentationController?.sourceView = self.view
               present(activityViewController, animated: true, completion: nil)
           }else{
               print("There is nothing to share")
           }
       }
    @IBAction func actionOnCloseStickerView(_ sender: Any) {
        
       
        self.backViewSticker.isHidden = true
//        let ShareStickerVC : HomeVC = UIStoryboard(name: "main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//
//         self.present(ShareStickerVC, animated: true, completion: nil)
//        self.backViewPhotoSticker.isHidden = true
//                 // self.menuView.isHidden = false
//                  self.btnCoverScreen.isHidden = false
//                  self.octoStackView.isHidden = false
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func actionOnStickers(_ sender: Any) {
         self.backViewStickers.isHidden = false
        self.backViewTypefaces.isHidden = true
        self.backViewFrames.isHidden = true
        
        self.btnSticker.backgroundColor = UIColor.lightGray
        self.btnTypeFace.backgroundColor = UIColor.white
        self.btnFrames.backgroundColor = UIColor.white
    }
    
    @IBAction func actionOnTypeFace(_ sender: Any) {
        
        self.backViewTypefaces.isHidden = false
        self.backViewStickers.isHidden = true
        self.backViewFrames.isHidden = true
        
        self.btnTypeFace.backgroundColor = UIColor.lightGray
        self.btnSticker.backgroundColor = UIColor.white
        self.btnFrames.backgroundColor = UIColor.white
    }
    
    @IBAction func actionOnFrames(_ sender: Any) {
        
        self.backViewFrames.isHidden = false
        self.backViewTypefaces.isHidden = true
        self.backViewStickers.isHidden = true
        
        self.btnFrames.backgroundColor = UIColor.lightGray
        self.btnTypeFace.backgroundColor = UIColor.white
        self.btnSticker.backgroundColor = UIColor.white
    }
    
    
}


extension HomeVC {
    
  func customize() {
           self.navigationController?.navigationBar.isHidden = false
    self.btnSticker.backgroundColor = UIColor.lightGray
           self.backViewPhotoSticker.isHidden = true
           self.backViewSticker.isHidden = true
           self.backViewTypefaces.isHidden = true
           self.backViewFrames.isHidden = true
           
    
          // self.btnEdit.layer.cornerRadius = 35
           //self.btnEdit.layer.cornerRadius = btnEdit.frame.size.width / 2
           config.onlySquareImagesFromCamera = false
    config.screens = [YPPickerScreen.library, YPPickerScreen.photo]
           config.albumName = "Octo"
           config.shouldSaveNewPicturesToAlbum = false
           config.showsCrop = .none
           config.targetImageSize = .original
           config.showsPhotoFilters = true
           config.library.maxNumberOfItems = 5
           config.library.mediaType = .photo
           config.startOnScreen = .library
         //  config.video.compression = AVAssetExportPresetHighestQuality
           picker = YPImagePicker(configuration: config)
           picker.didFinishPicking { [unowned picker] items, cancelled in
            if cancelled {
                self.backViewPhotoSticker.isHidden = true
                      // self.menuView.isHidden = false
                       self.btnCoverScreen.isHidden = false
                       self.octoStackView.isHidden = false
                       self.navigationController?.navigationBar.isHidden = false
                print("Picker was canceled")
                picker.dismiss(animated: true, completion: nil)
            } else {
                for item in items {
                    switch item {
                    case .photo(let photo):
                        self.backViewPhotoSticker.isHidden = false
                       self.PhotoEditImage.image = photo.image
//                         self.NextToEditPhoto()
                         break
                    case .video(let _):
                         break
                    }
                }
                
                picker.dismiss(animated: true, completion: {
//                    self.items += items
//                    self.photo = []
//                    self.typeOfData = []
//                    self.UpdateData(ypItems: self.items)
                    //self.items += items
                   // self.sliderCollectionView.reloadData()
                })
                picker.dismiss(animated: true, completion: nil)
            }
        }
    
    
    // Collection View Cell
    
    self.CollectionViewLatestStickers.layer.cornerRadius = 20
    self.CollectionViewLatestGif.layer.cornerRadius = 20
    
    self.CollectionViewLatestTypefaces.layer.cornerRadius = 20
    
    
    
  ///  self.CollectionViewLatestGif.register(LatestGifCollectionCell.self, forCellWithReuseIdentifier: "LatestGif")
    LatestStickers = ["sticker1","sticker2","sticker3","sticker1"]
    LatestGif = ["sticker1","sticker2"]
    Stickers = ["sticker1","sticker2","sticker3","sticker1","sticker2","sticker3","sticker1","sticker2","sticker3","sticker1","sticker2","sticker3","sticker1","sticker2","sticker3","sticker1","sticker2","sticker3","sticker1","sticker2","sticker3","sticker1","sticker2","sticker3","sticker1","sticker2","sticker3","sticker1","sticker2","sticker3","sticker1","sticker2","sticker3","sticker1","sticker2","sticker3"]
    
    self.CollectionViewLatestStickers.register(UINib(nibName: "StickersGifCollectionCell", bundle: nil), forCellWithReuseIdentifier: "StickerGifCell")
     // self.CollectionViewLatestGif.register(LatestGifCollectionCell.self, forCellWithReuseIdentifier: "LatestGif")
    
    self.CollectionViewLatestGif.register(UINib(nibName: "StickersGifCollectionCell", bundle: nil), forCellWithReuseIdentifier: "StickerGifCell")
    
    self.CollectionViewStickers.register(UINib(nibName: "StickersGifCollectionCell", bundle: nil), forCellWithReuseIdentifier: "StickerGifCell")
        
    }
    
    func NextToEditPhoto() {
        
//        let Photo = PhotoEditVC()
//        Photo.ReceivedImage = self.selectedImage
//        self.navigationController?.pushViewController(Photo, animated: true)
    }
}




extension HomeVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var count = 0
        if collectionView == CollectionViewLatestStickers {
                  count = self.LatestStickers.count
        }
        else if collectionView == CollectionViewLatestGif {

            count = self.LatestGif.count
        }
        else if collectionView == CollectionViewStickers{
            count = self.Stickers.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // let cell = CollectionViewLatestStickers.dequeueReusableCell(withReuseIdentifier: "LatestStickersCell", for: indexPath) as! LatestStickersCollectionCell
        if collectionView == CollectionViewLatestStickers {
        let cell = CollectionViewLatestStickers.dequeueReusableCell(withReuseIdentifier: "StickerGifCell", for: indexPath) as! StickersGifCollectionCell
        
        let stickerImage = UIImage(named: LatestStickers[indexPath.row])
       // cell.LatestStickersImg.image = stickerImage
        cell.StickersImage.image = stickerImage
        
        return cell
    }
    else if collectionView == CollectionViewLatestGif {
      //   let cell = CollectionViewLatestGif.dequeueReusableCell(withReuseIdentifier: "LatestGif", for: indexPath) as! LatestGifCollectionCell
             let cell = CollectionViewLatestGif.dequeueReusableCell(withReuseIdentifier: "StickerGifCell", for: indexPath) as! StickersGifCollectionCell
            let GifImage = UIImage(named: LatestGif[indexPath.row])
                 
            cell.StickersImage.image = GifImage
            
            return cell
    }
        
    else if collectionView == CollectionViewStickers {
           let cell = CollectionViewStickers.dequeueReusableCell(withReuseIdentifier: "StickerGifCell", for: indexPath) as! StickersGifCollectionCell

            let stickersImage = UIImage(named: Stickers[indexPath.row])

            cell.StickersImage.image = stickersImage

            return cell


    }
        
        return UICollectionViewCell()
    
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Click Collection cell \(indexPath.item)")
        if collectionView == CollectionViewLatestStickers {
           //  let cell = CollectionViewLatestStickers.dequeueReusableCell(withReuseIdentifier: "StickerGifCell", for: indexPath) as! StickersGifCollectionCell
           if let cell = collectionView.cellForItem(at: indexPath) as? StickersGifCollectionCell{
            if let imageSticker = cell.StickersImage.image {
                
                
                // UIImageView as a container
                
                let testImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
                               testImage.image = imageSticker
                               testImage.contentMode = .scaleAspectFit
                               let stickerView3 = StickerView.init(contentView: testImage)
                               stickerView3.center = CGPoint.init(x: 150, y: 150)
                               stickerView3.delegate = self as? StickerViewDelegate
                               stickerView3.setImage(UIImage.init(named: "Close")!, forHandler: StickerViewHandler.close)
                               stickerView3.setImage(UIImage.init(named: "Rotate")!, forHandler: StickerViewHandler.rotate)
                             //  stickerView3.setImage(UIImage.init(named: "Flip")!, forHandler: StickerViewHandler.flip)
                               stickerView3.showEditingHandlers = false
                               stickerView3.tag = 999
                             
                              // self.view.addSubview(stickerView3)
                              self.PhotoEditImage.addSubview(stickerView3)
                               self.selectedStickerView = stickerView3
                               
                               self.backViewSticker.isHidden = true
                
                
//                    let testImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
//                     testImage.image = imageSticker
//
//                    testImage.contentMode = .scaleAspectFit
//
//                     let stickerView = StickerView.init(contentView: testImage)
//                     stickerView.center = CGPoint.init(x: 150, y: 150)
//                     stickerView.delegate = self as? StickerViewDelegate
//                     stickerView.setImage(UIImage.init(named: "Close")!, forHandler: StickerViewHandler.close)
//                     stickerView.setImage(UIImage.init(named: "Rotate")!, forHandler: StickerViewHandler.rotate)
//                     stickerView.setImage(UIImage.init(named: "Flip")!, forHandler: StickerViewHandler.flip)
//                     stickerView.showEditingHandlers = false
//                     stickerView.tag = 999
//                     // self.view.addSubview(stickerView)
//                      self.PhotoEditImage.addSubview(stickerView)
//                     // first off assign handler to stickerView
//                     self.selectedStickerView = stickerView
//
                   print("Sticker loaded")
               }else{
                   print("Sticker not loaded")
               }
           }
        }
        else if collectionView == CollectionViewLatestGif {


        }
        else if collectionView == CollectionViewStickers {


        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

       
         let noOfCellsInRow = 4

         let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

         let totalSpace = flowLayout.sectionInset.left
             + flowLayout.sectionInset.right
             + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

         let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

         return CGSize(width: size, height: size)
        
     }
}


extension HomeVC : StickerViewDelegate {
    func stickerViewDidBeginMoving(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
    
    func stickerViewDidChangeMoving(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndMoving(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidBeginRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidChangeRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidClose(_ stickerView: StickerView) {
        
    }
    
    
    func stickerViewDidTap(_ stickerView: StickerView) {
      self.selectedStickerView = stickerView
  }

}
