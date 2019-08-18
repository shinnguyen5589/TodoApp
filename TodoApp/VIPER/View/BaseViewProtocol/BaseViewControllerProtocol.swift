//
//  BaseViewControllerProtocol.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

public protocol BaseViewControllerProtocol {
    
    /// Setup views, copoment -> call in viewDidLoad
    func setupViews ()
    
    /// Setup layout, contraints -> call in viewDidLoad
    func setupLayout()
    
    /// Setup navigation bar -> call in viewDidLoad
    func setUpNavigationBar()
}
