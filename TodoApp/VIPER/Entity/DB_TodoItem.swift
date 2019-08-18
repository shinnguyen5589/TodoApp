//
//  TodoItem.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

@objcMembers public class TodoItem: Object {
    enum Property: String {
        case id, name, isDone
    }
    
    dynamic var id = UUID().uuidString
    dynamic var name = ""
    dynamic var isDone = false
    
    override public static func primaryKey() -> String? {
        return TodoItem.Property.id.rawValue
    }
    
    convenience init(_ name: String) {
        self.init()
        self.name = name
    }
}
