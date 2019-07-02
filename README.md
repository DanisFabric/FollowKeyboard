# FollowKeyboard

Keep your views visible when keyboard is being shown.

## Screens

![screen 1](https://github.com/DanisFabric/FollowKeyboard/blob/master/screens/screen1.gif)

## Requirements

- iOS 8.0 + 
- Swift 5.0 +

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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        fk.unfollowKeyboard()
    }
    
       
```

### Layout using Autolayout

```Swift
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
```

> You'd better add the code to `viewWillAppear:` and `viewWillDisappear`

## Contact 

contact me: [danisfabric@gmail.com](danisfabric@gmail.com)



