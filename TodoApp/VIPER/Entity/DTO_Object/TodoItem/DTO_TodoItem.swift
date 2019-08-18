//
//  DTO_TodoItem.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

import Foundation

class DTO_TodoItem : NSObject {
    public var id: String = ""
    public var name: String = ""
    public var isDone: Bool = false
    
    init(id: String, name: String, isDone: Bool) {
        self.id = id
        self.name = name
        self.isDone = isDone
        
        super.init()
    }
}
