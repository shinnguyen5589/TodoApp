//
//  TodoItemAssembler+Extension.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

extension TodoItemAssembler {
    // From DB object to DBModel object
    static func convertToDBModelList(from dbObjects: [DB_TodoItem]) -> [DBModel_TodoItem] {
        return dbObjects.map({ (dbObject) -> DBModel_TodoItem in
            return DBModel_TodoItem(id: dbObject.id, name: dbObject.name, isDone: dbObject.isDone, localCreatedAt: dbObject.localCreatedAt)
        })
    }
    
    static func convertToDBModel(from dbObject: DB_TodoItem) -> DBModel_TodoItem {
        return DBModel_TodoItem(id: dbObject.id, name: dbObject.name, isDone: dbObject.isDone, localCreatedAt: dbObject.localCreatedAt)
    }
}
