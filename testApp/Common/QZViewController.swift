//
//  QZViewController.swift
//  testApp
//
//  Created by Developer on 12/5/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit

class QZViewController: UIViewController {

    var backBtn:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //back
        backBtn = UIButton(type: .custom)
        let img = UIImage(named: "back_arrow")?.resizedImage(newWidth: 12)
        backBtn.setImage(img, for: UIControlState())
        backBtn.addTarget(self, action:#selector(QZViewController.goBack(_:)), for: UIControlEvents.touchUpInside)
        backBtn.frame = CGRect(x: 0, y: 0, width: img!.size.width, height: img!.size.height)
        let bck = UIBarButtonItem(customView: backBtn)
        self.navigationItem.leftBarButtonItem=bck
        self.view.backgroundColor = QZThemeColor
        if self.navigationController != nil && self.navigationController!.isKind(of: QZNavigationController.classForCoder()){
            (self.navigationController as! QZNavigationController).updateNavBar()
        }
        resizeNavBarItems(left: false)
        resizeNavBarItems(left: true)
    }
    func resizeNavBarItems(left:Bool){
        guard let items = left ? self.navigationItem.leftBarButtonItems : self.navigationItem.rightBarButtonItems else {return}
        
        for i in items{
            if let img = i.image {
                i.image = img.resizedImage(newWidth:18)
            }
            
        }
    }
    func setTitleLabel(title:String){
        let titleView=UILabel()
        titleView.font = navbarTitleFont
        titleView.text = title
        titleView.sizeToFit()
        titleView.textColor = UIColor.white
        self.navigationItem.titleView = titleView
    }
    @IBAction func goBack(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        if self.navigationController != nil && self.navigationController!.isKind(of: QZNavigationController.classForCoder()){
            (self.navigationController as! QZNavigationController).updateNavBar()
        }
        super.viewWillAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
