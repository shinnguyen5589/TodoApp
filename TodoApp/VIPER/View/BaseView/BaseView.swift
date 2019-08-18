//
//  BaseView.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

open class BaseView: UIView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
        self.setupLayout()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupViews() {
        //
    }
    
    open func setupLayout() {
        //
    }
}
