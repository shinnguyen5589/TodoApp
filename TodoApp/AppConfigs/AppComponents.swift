//
//  AppComponents.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

class AppComponents: NSObject {
    private static var _todoItemManager: TodoItemManager!
    static var todoItemManager: TodoItemManager { return _todoItemManager }
    
    private static var _todoTextService: TodoTextService!
    static var todoTextService: TodoTextService { return _todoTextService }
    
    static func setup() {
        self._todoItemManager = TodoItemManager()
        self._todoTextService = TodoTextService()
    }
}
