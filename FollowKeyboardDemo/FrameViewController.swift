//
//  FrameViewController.swift
//  FollowKeyboardDemo
//
//  Created by Danis on 16/1/21.
//  Copyright © 2016年 danis. All rights reserved.
//

import UIKit
import FollowKeyboard

class FrameViewController: UIViewController {

    let bottomBar = UIView()
    let inputTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bottomBar.backgroundColor = UIColor.purple
        bottomBar.frame = CGRect(x: 0, y: view.frame.height - 60, width: view.frame.width, height: 60)
        
        inputTextField.placeholder = "Please say Hi"
        inputTextField.backgroundColor = UIColor.clear
        inputTextField.frame = bottomBar.bounds.insetBy(dx: 5, dy: 5)
        inputTextField.textColor = UIColor.white
        
        let tapBackground = UITapGestureRecognizer(target: self, action: #selector(onTapBackground(tap:)))
        view.addGestureRecognizer(tapBackground)
    
        view.addSubview(bottomBar)
        bottomBar.addSubview(inputTextField)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let fk = FollowKeyboard()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fk.followKeyboard(withAnimations: { [unowned self] (keyboardFrame, duration, type) in
            switch type {
            case .show:
                self.bottomBar.frame = self.bottomBar.frame.offsetBy(dx: 0, dy: -keyboardFrame.height)
            case .hide:
                self.bottomBar.frame = self.bottomBar.frame.offsetBy(dx: 0, dy: keyboardFrame.height)
            }
        }, completionBlock: nil)
    }
    
    @objc private func onTapBackground(tap: UITapGestureRecognizer) {
        inputTextField.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
