//
//  TodoItemManagerMock.swift
//  TodoAppTests
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

import Foundation

class TodoItemManagerMock: NSObject, TodoItemManaging {
    
    private var _todoList: [DBModel_TodoItem] = []
    
    func getAll() -> [DBModel_TodoItem] {
        return self._todoList
    }
    
    func add(name: String) -> DBModel_TodoItem? {
        let dbModel = DBModel_TodoItem(id: UUID().uuidString, name: name, isDone: false, localCreatedAt: Date())
        self._todoList.append(dbModel)
        return dbModel
    }
    
    func deleteTodoItem(with id: String) -> Bool {
        for (index, item) in self._todoList.enumerated() {
            if item.id == id {
                self._todoList.remove(at: index)
                return true
            }
        }
        
        return false
    }
    
    func deleteAllTodoList() {
        self._todoList.removeAll()
    }
    
    func updateItemStatus(with id: String) -> DBModel_TodoItem? {
        let item = self._todoList.filter{ $0.id == id }.first
        guard let _item = item else { return nil }
        _item.isDone = !_item.isDone
        return _item
    }
}
