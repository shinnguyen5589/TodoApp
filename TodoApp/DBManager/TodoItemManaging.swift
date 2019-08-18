//
//  DBManaging_Alarm.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

public protocol DBTodoItem_Managing {
    func add(name: String)
    func deleteTodoItem(item: TodoItem)
    func deleteAllTodoItems()
}
