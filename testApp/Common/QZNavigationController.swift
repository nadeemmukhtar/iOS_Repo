//
//  QZNavigationController.swift
//  testApp
//
//  Created by Developer on 12/5/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit

class QZNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = UIColor.white
        navigationBar.barTintColor = QZThemeColor
        navigationBar.shadowImage=UIImage()
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        navigationBar.isTranslucent=false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func updateNavBar(){
        if viewControllers.count>1 || (viewControllers.first!.isKind(of: QZViewController.classForCoder())) {
            setNavigationBarHidden(false, animated: false)
        }else{
            setNavigationBarHidden(true, animated: false)
        }
        if viewControllers.count == 1 && viewControllers.last!.isKind(of: QZViewController.classForCoder()){
            (viewControllers.last! as! QZViewController).backBtn.isHidden = true
        }
        
    }
    override func popViewController(animated: Bool) -> UIViewController? {
        let vc = super.popViewController(animated: animated)
        updateNavBar()
        return vc
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        updateNavBar()
    }

}
