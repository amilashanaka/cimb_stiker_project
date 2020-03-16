//
//  TutorialViewController.swift
//  WAStickersThirdParty
//
//  Created by AXAT Mac mini 3 (2019) on 23/12/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionOnBackBtn(_ sender: Any) {
        
        //self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        print("tap")
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
