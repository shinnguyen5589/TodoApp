//
//  DB_TodoItem.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

@objcMembers public class DB_TodoItem: Object {
    enum Property: String {
        case id, name, isDone, localCreatedAt
    }
    
    dynamic var id = UUID().uuidString
    dynamic var name = ""
    dynamic var isDone = false
    dynamic var localCreatedAt: Date = Date()
    
    override public static func primaryKey() -> String? {
        return DB_TodoItem.Property.id.rawValue
    }
    
    convenience init(_ name: String) {
        self.init()
        self.name = name
    }
}
