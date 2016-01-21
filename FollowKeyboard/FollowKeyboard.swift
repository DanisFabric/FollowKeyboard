//
//  FollowKeyboard.swift
//  FollowKeyboard
//
//  Created by Danis on 16/1/21.
//  Copyright © 2016年 danis. All rights reserved.
//

import UIKit

public enum FollowKeyboardType : Equatable{
    case Show
    case Hide
}

public func ==(lhs: FollowKeyboardType, rhs: FollowKeyboardType) -> Bool {
    switch (lhs,rhs) {
    case (.Show,.Show):
        return true
    case (.Hide, .Hide):
        return true
    default:
        return false
    }
}

public typealias FollowKeyboardAnimationsBlock = (keyboardFrame: CGRect,duration: Double, type: FollowKeyboardType) -> Void
public typealias FollowKeyboardCompletionBlock = (finished: Bool) -> Void

private let AnimationsBlockKey = "FKAnimationsBlock"
private let CompletionBlockKey = "FKCompletionBlock"

public class FollowKeyboard: NSObject {
    
    private var animationsBlock: FollowKeyboardAnimationsBlock?
    private var completionBlock: FollowKeyboardCompletionBlock?
    
    public override init() {
        super.init()
    }
    
    public func followKeyboard(withAnimations animationsBlock: FollowKeyboardAnimationsBlock?, completionBlock: FollowKeyboardCompletionBlock?) {
        
        self.animationsBlock = animationsBlock
        self.completionBlock = completionBlock
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    public func unfollowKeyboard() {
        
        self.animationsBlock = nil
        self.completionBlock = nil
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func onKeyboardWillShowNotification(notifcation: NSNotification) {
        commitAnimationsWithNotification(notifcation, type: .Show)
    }
    func onKeyboardWillHideNotification(notifcation: NSNotification) {
        commitAnimationsWithNotification(notifcation, type: .Hide)
    }
    private func commitAnimationsWithNotification(notification: NSNotification, type: FollowKeyboardType) {
        let keyboardFrame = notification.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey]?.integerValue
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey]?.doubleValue
        
        UIView.animateWithDuration(duration!, delay: 0, options: [.BeginFromCurrentState], animations: { () -> Void in
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: curve!)!)
            
            self.animationsBlock?(keyboardFrame: keyboardFrame!, duration: duration!, type: type)
            
            }, completion: completionBlock)
        
    }
}
