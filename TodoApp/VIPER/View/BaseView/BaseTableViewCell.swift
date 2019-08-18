//
//  BaseTableViewCell.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

open class BaseTableViewCell : UITableViewCell {
    
    open class var CELL_IDENTIFIER: String { return "" }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupViews()
        self.setupLayout()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Setup init view component.
    func setupViews() {
        //
    }
    
    /// Setup Layout for view component
    func setupLayout() {
        //
    }
}
