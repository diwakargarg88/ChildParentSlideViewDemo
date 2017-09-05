//
//  ViewController.swift
//  ChildParentSlideViewDemo
//
//  Created by Diwakar Garg on 31/08/17.
//  Copyright © 2017 Diwakar Garg. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ChildNameDelegate {

    var label : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 3.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.masksToBounds = false
        
        
        
        let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 60))
        //        customView.backgroundColor = UIColor.yellow
        
        let  menuButton = UIButton.init(type: .custom)
                menuButton.setBackgroundImage(UIImage(named: "Menu-w"), for: .normal)
        menuButton.frame = CGRect(x: 0.0, y: 5.0, width: 25.0, height: 25.0)
        menuButton.center.y = customView.center.y
        //        menuButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        customView.addSubview(menuButton)
        
        let marginX = CGFloat(menuButton.frame.origin.x + menuButton.frame.size.width + 30)
        label = UILabel(frame: CGRect(x: marginX, y: 0.0, width: self.view.frame.width - marginX, height: customView.frame.height))
        label.text = "Base View"
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.left
        label.center.y = customView.center.y
        //        label.font =  UIFont(name: "Roboto-Bold", size: 20)
        //        label.backgroundColor = UIColor.red
        customView.addSubview(label)
        let leftButton = UIBarButtonItem(customView: customView)
        self.navigationItem.leftBarButtonItem = leftButton
        

        // Do any additional setup after loading the view, typically from a nib.
    }
    //Change Value of navigation Bar
  func setLabel(text:String) {
        self.label.text = text
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addBottomSheetView()
    }
//    func showOverLayer()
//    {
//        let bottomSheetVC = storyboard?.instantiateViewController(withIdentifier: "childView") as! ChildViewController
//        bottomSheetVC.didMove(toParentViewController: self)
//        let height = view.frame.height
//        let width  = view.frame.width
//        bottomSheetVC.view.frame = CGRect(x: 0, y: 0, width: width, height: height - 65)
//        self.view.addSubview(bottomSheetVC.view)
//        self.addChildViewController(bottomSheetVC)
//    }
//    
    func addBottomSheetView(scrollable: Bool? = true) {
        let bottomSheetVC = storyboard?.instantiateViewController(withIdentifier: "childView") as! ChildViewController
        bottomSheetVC.delegate = self
        bottomSheetVC.didMove(toParentViewController: self)
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: height - 20, width: width, height: height - 65)
        self.view.addSubview(bottomSheetVC.view)
        self.addChildViewController(bottomSheetVC)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

