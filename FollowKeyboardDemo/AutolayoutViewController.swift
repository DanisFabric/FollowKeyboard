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
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        fk.followKeyboard(withAnimations: { (keyboardFrame, duration, type) -> Void in
            
            switch type {
            case .Show:
                self.barBottomConstaint.constant += keyboardFrame.height
                self.view.layoutIfNeeded()
            case .Hide:
                self.barBottomConstaint.constant -= keyboardFrame.height
                self.view.layoutIfNeeded()
            }
            
            }) { (finished) -> Void in
                
        }
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        fk.unfollowKeyboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapBackground(sender: AnyObject) {
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
