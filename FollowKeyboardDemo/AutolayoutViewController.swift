//
//  AutolayoutViewController.swift
//  FollowKeyboardDemo
//
//  Created by Danis on 16/1/21.
//  Copyright © 2016年 danis. All rights reserved.
//

import UIKit
import FollowKeyboard

class AutolayoutViewController: UIViewController {

    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var barBottomConstaint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    let fk = FollowKeyboard()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fk.followKeyboard(withAnimations: { (keyboardFrame, duration, type) in
            switch type {
            case .show:
                self.barBottomConstaint.constant += keyboardFrame.height
                self.view.layoutIfNeeded()
            case .hide:
                self.barBottomConstaint.constant -= keyboardFrame.height
                self.view.layoutIfNeeded()
            }
        }, completionBlock: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        fk.unfollowKeyboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTouchBackgroundView(_ sender: Any) {
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
