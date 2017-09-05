//
//  ChildViewController.swift
//  ChildParentSlideViewDemo
//
//  Created by Diwakar Garg on 31/08/17.
//  Copyright © 2017 Diwakar Garg. All rights reserved.
//

import UIKit

protocol ChildNameDelegate {
    func setLabel(text: String)
}


class ChildViewController: UIViewController {

    var delegate: ChildNameDelegate?
    
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var holdView: UIView!
    var tap : Bool = false
    
    let fullView: CGFloat = 65
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(ChildViewController.panGesture))
        view.addGestureRecognizer(gesture)
        
        
        //Add gesture to view
        let swipeUpView = UITapGestureRecognizer(target: self, action: #selector(self.overLayView))
        self.sliderView.addGestureRecognizer(swipeUpView)
        
        let tapUpView = UITapGestureRecognizer(target: self, action: #selector(self.overLayView))
        self.holdView.addGestureRecognizer(tapUpView)
        
        self.holdView.layer.cornerRadius = self.holdView.frame.size.height / 2
        
        // Do any additional setup after loading the view.
    }
    
    func overLayView()
    {
        
        if  tap == false {
            UIView.animate(withDuration: 0.3, animations: {
                let frame = self.view.frame
                self.view.frame = CGRect(x: 0, y: self.fullView, width: frame.width, height: frame.height)
                self.tap = true
                self.delegate?.setLabel(text: "child")
            })
        }
        else
        {
            CloseButtonAction(self)
        }

       
    }
    
    @IBAction func CloseButtonAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            let frame = self.view.frame
            self.view.frame = CGRect(x: 0, y: self.partialView, width: frame.width, height: frame.height)
            self.tap = false
            self.delegate?.setLabel(text: "Base")
        })
    }
    
    //Custom Function
    
    func panGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        let y = self.view.frame.minY
        if ( y + translation.y >= fullView) && (y + translation.y <= partialView ) {
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                    self.tap = false
                    self.delegate?.setLabel(text: "Base")
                    
                } else {
                    self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                    self.tap = true
                    self.delegate?.setLabel(text: "child")
                }
                
            }, completion: nil)
        }
    }
    
    
    func prepareBackgroundView(){
        let effect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: effect)
        blurView.frame = self.view.bounds
        self.view.addSubview(blurView)
        self.view.sendSubview(toBack: blurView)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
