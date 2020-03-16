//
//  ShareStickerVC.swift
//  WAStickersThirdParty
//
//  Created by AXAT Mac mini 3 (2019) on 24/12/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import UIKit

class ShareStickerVC: UIViewController {

    @IBOutlet weak var ShareImage: UIImageView!
    
    @IBOutlet weak var btnShare: UIButton!
    
    @IBOutlet weak var btnHome: UIView!
    
    var receivedImage : UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ShareImage.image = receivedImage
        self.navigationController?.navigationBar.isHidden = false
    }
    
  // MARK: - Action On Buttons
    @IBAction func actionOnHomeBtn(_ sender: Any) {
      //  let homeController =  HomeVC()
       // self.navigationController?.pushViewController(homeController, animated: true)
         let HomeVC : HomeVC = UIStoryboard(name: "main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        HomeVC.navigationController?.navigationBar.isHidden = false
         self.navigationController?.navigationBar.isHidden = false
       // self.navigationController?.present(HomeVC, animated: true, completion: nil)
//        HomeVC.navigationController?.navigationBar.isHidden = false
        self.present(HomeVC, animated: true, completion: nil)
        self.navigationController?.navigationBar.isHidden = false
      
    }
    
    @IBAction func actionOnShareBtn(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
