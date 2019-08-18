//
//  DBModel_TodoItem.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

import Foundation

public class DBModel_TodoItem : NSObject {
    public var id: String
    public var name: String
    public var isDone: Bool
    public var localCreatedAt: Date = Date()
    
    init(id: String, name: String, isDone: Bool, localCreatedAt: Date) {
        self.id = id
        self.name = name
        self.isDone = isDone
        self.localCreatedAt = localCreatedAt
        
        super.init()
    }
}
