//
//  TodoButton.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

class TodoButton: UIButton {
    
    // Bool property
    open var isActive: Bool = false {
        didSet {
            self.setActive(self.isActive)
        }
    }
    
    open var activeBackgroundColor: UIColor = UIColor.green {
        didSet {
            self.setActive(self.isActive)
        }
    }
    
    // MARK: Private params
    private let cornerRadius: CGFloat = 5.0
    
    // MARK: Override functions and params
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setActive(false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setActive(false)
    }
    
    override var isEnabled: Bool {
        get {
            return super.isEnabled
        }
        set {
            self.setBackgroundColor(isHighlighted: self.isHighlighted, isEnabled: newValue)
            super.isEnabled = newValue
        }
    }
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            self.setBackgroundColor(isHighlighted: newValue, isEnabled: self.isEnabled)
            super.isHighlighted = newValue
        }
    }
    
    private func setActive(_ isActive: Bool) {
        if isActive {
            self.backgroundColor = activeBackgroundColor
            self.layer.borderWidth = 0
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.cornerRadius = self.cornerRadius
            self.setTitleColor(UIColor.white, for: .normal)
        } else {
            self.backgroundColor = UIColor.white
            self.layer.borderWidth = 1.0
            self.layer.borderColor = UIColor.lightGray.cgColor
            self.layer.cornerRadius = self.cornerRadius
            self.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    private func setBackgroundColor(isHighlighted: Bool, isEnabled: Bool) {
        if isHighlighted && isActive {
            self.backgroundColor = self.activeBackgroundColor.withAlphaComponent(0.6)
        } else if isEnabled && isActive {
            self.backgroundColor = self.activeBackgroundColor
        } else {
            self.backgroundColor = UIColor.white
        }
    }
}
