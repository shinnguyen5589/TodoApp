//
//  TodoItemManaging.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

public protocol TodoItemManaging {
    func getAll() -> [DBModel_TodoItem]
    func add(name: String) -> DBModel_TodoItem?
    func deleteTodoItem(with id: String) -> Bool
    func deleteAllTodoList()
    func updateItemStatus(with id: String) -> DBModel_TodoItem?
}
