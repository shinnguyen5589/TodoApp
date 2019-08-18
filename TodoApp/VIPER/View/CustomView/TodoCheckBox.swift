//
//  TodoCheckBox.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

open class TodoCheckBox: UIButton {
    // Images
    open var checkedImage: UIImage? = nil {
        didSet {
            if self.isChecked {
                self.setImage(checkedImage, for: UIControl.State())
            }
        }
    }
    
    open var uncheckedImage: UIImage? = nil {
        didSet {
            if !self.isChecked {
                self.setImage(uncheckedImage, for: UIControl.State())
            }
        }
    }
    
    // Bool property
    open var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State())
            } else {
                self.setImage(uncheckedImage, for: UIControl.State())
            }
        }
    }
    
    open var borderColor: UIColor = UIColor.black {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        self.isChecked = false
        // self.layer.borderWidth = 1
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
            self.sendActions(for: .valueChanged)
        }
    }
}
