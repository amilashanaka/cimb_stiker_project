//
//  TutorialLensesPageVC.swift
//  WAStickersThirdParty
//
//  Created by AXAT Mac mini 3 (2019) on 23/12/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import UIKit

class TutorialLensesPageVC: UIPageViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource {
   
    

     var pageControl = UIPageControl()
     var pageNo = Int()
    
    // MARK: UIPageViewControllerDataSource
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVc(viewController: "Sticker-1"),
                self.newVc(viewController: "Sticker-2"),self.newVc(viewController: "Sticker-3"),
                self.newVc(viewController: "Sticker-4"),self.newVc(viewController: "Sticker-5"),
                self.newVc(viewController: "Sticker-6"),self.newVc(viewController: "Sticker-7"),
               ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self
        
        
        
        // This sets up the first view that will show up on our page control
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        configurePageControl()
    }
    
    func configurePageControl() {
          // The total number of pages that are available is based on how many available colors we have.
          pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
          self.pageControl.numberOfPages = orderedViewControllers.count
          self.pageControl.currentPage = 0
          self.pageControl.tintColor = UIColor.black
          self.pageControl.pageIndicatorTintColor = UIColor.white
          self.pageControl.currentPageIndicatorTintColor = UIColor.black
          self.view.addSubview(pageControl)
        
//        let button:UIButton = UIButton(frame: CGRect(x: 255, y: UIScreen.main.bounds.maxY - 50, width: 100, height: 30))
//        button.setTitleColor(.darkGray, for: .normal)
//        button.setTitle("BACK", for: .normal)
//        button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
//        self.view.addSubview(button)
//
//         button.isHidden = true
//        button.isHidden = pageNo == 6
        
//        button.isHidden = pageNo == 0
//        button.isHidden = pa
        
      }
    
    @objc func buttonClicked() {
        // self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
//        let suggestionController = HomeVC()
//        self.navigationController?.pushViewController(suggestionController, animated: true)
               
               print("Button Clicked")
           }
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
     // MARK: Delegate methords
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
          let pageContentViewController = pageViewController.viewControllers![0]
          self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
      }
      
    
     // MARK: Data source functions.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
              guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
                     return nil
                 }
                 
                 let previousIndex = viewControllerIndex - 1
                 
                 // User is on the first view controller and swiped left to loop to
                 // the last view controller.
                 guard previousIndex >= 0 else {
                    
                  
                          
                     return orderedViewControllers.last
                     // Uncommment the line below, remove the line above if you don't want the page control to loop.
                     // return nil
                 }
                 
                 guard orderedViewControllers.count > previousIndex else {
                     return nil
                 }
                 
                 return orderedViewControllers[previousIndex]
             }
    
       
       func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
           guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
                   return nil
               }
               
               let nextIndex = viewControllerIndex + 1
        print(nextIndex)
               let orderedViewControllersCount = orderedViewControllers.count
               
              if nextIndex == 6 {
                 let button:UIButton = UIButton(frame: CGRect(x: 255, y: UIScreen.main.bounds.maxY - 50, width: 100, height: 30))
                  button.setTitleColor(.darkGray, for: .normal)
                  button.setTitle("BACK", for: .normal)
                  button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
                  self.view.addSubview(button)

                
              }
               // User is on the last view controller and swiped right to loop to
               // the first view controller.
               guard orderedViewControllersCount != nextIndex else {
                   return orderedViewControllers.first
                   // Uncommment the line below, remove the line above if you don't want the page control to loop.
                   // return nil
               }
               
               guard orderedViewControllersCount > nextIndex else {
                   return nil
               }
               
               return orderedViewControllers[nextIndex]
           }
      
}
