//
//  BaseViewController.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

open class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.setupLayout()
        self.setUpNavigationBar()
    }
    
    open func setupViews() {
        //
    }
    
    open func setupLayout() {
        //
    }
    
    open func setUpNavigationBar() {
        //
    }
}
