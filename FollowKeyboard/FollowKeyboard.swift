//
//  FollowKeyboard.swift
//  FollowKeyboard
//
//  Created by Danis on 16/1/21.
//  Copyright © 2016年 danis. All rights reserved.
//

import UIKit

private let AnimationsBlockKey = "FKAnimationsBlock"
private let CompletionBlockKey = "FKCompletionBlock"

public class FollowKeyboard: NSObject {
    public enum AppearType {
        case show
        case hide
        
        public var isShow: Bool {
            return self == .show
        }
        
        public var isHide: Bool {
            return self == .hide
        }
    }
    
    private var animationsBlock: ((CGRect,Double, AppearType) -> Void)?
    private var completionBlock: ((Bool) -> Void)?
    
    public override init() {
        super.init()
    }
    
    public func followKeyboard(withAnimations animationsBlock: ((CGRect,Double, AppearType) -> Void)?, completionBlock: ((Bool) -> Void)?) {
        
        self.animationsBlock = animationsBlock
        self.completionBlock = completionBlock
        
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillShow(notifcation:)), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillHide(notifcation:)), name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    public func unfollowKeyboard() {
        
        self.animationsBlock = nil
        self.completionBlock = nil
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func onKeyboardWillShow(notifcation: NSNotification) {
        commitAnimations(notification: notifcation, type: .show)
    }
    @objc private func onKeyboardWillHide(notifcation: NSNotification) {
        commitAnimations(notification: notifcation, type: .hide)
    }
    private func commitAnimations(notification: NSNotification, type: AppearType) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        guard let curveRaw = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int else {
            return
        }
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState], animations: {
            UIView.setAnimationCurve(UIView.AnimationCurve(rawValue: curveRaw)!)
            
            self.animationsBlock?(keyboardFrame, duration, type)
            
        }, completion: completionBlock)
        
    }
}
