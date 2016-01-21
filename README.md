# FollowKeyboard

Keep your views visible when keyboard is being shown.

## Screens

![screen 1](https://github.com/DanisFabric/FollowKeyboard/blob/master/screens/screen1.gif)

## Requirements

- iOS 8.0 + 
- Swift 2.0 +

## Install

### Carthage

Add following to your `Cartfile` and run `Carthage update`. 

```ruby
github "DanisFabric/FollowKeyboard"
```

### Manual

add `FollowKeyboard.swift` to your project.

## Usage

### Layout using frame

```Swift
    let fk = FollowKeyboard()
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        fk.followKeyboard(withAnimations: { (keyboardFrame, duration, type) -> Void in
            
            switch type {
            case .Show:
                self.bottomBar.frame = CGRectOffset(self.bottomBar.frame, 0, -keyboardFrame.height)
            case .Hide:
                self.bottomBar.frame = CGRectOffset(self.bottomBar.frame, 0, keyboardFrame.height)
            }
            
            }) { (finished) -> Void in
                
        }
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        fk.unfollowKeyboard()
    } 
       
```

### Layout using Autolayout

```Swift
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
```

> You'd better add the code to `viewWillAppear:` and `viewWillDisappear`

## Contact 

[Danisfabric gmail](danisfabric@gmail.com)



