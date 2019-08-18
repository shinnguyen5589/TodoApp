//
//  TodoListInteractor.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

class TodoListInteractor: TodoListInteractorInputProtocol {
    
    weak var presenter: TodoListInteractorOutputProtocol?
    
    private var _todoItemManager: TodoItemManaging
    
    init(todoItemManager: TodoItemManaging) {
        self._todoItemManager = todoItemManager
    }
    
    func addTodoItem(name: String) {
        if let item = self._todoItemManager.add(name: name) {
            print("Added item with id \(item.id)successfully")
            self.presenter?.didAddTodoItemSuccess()
        } else {
            print("Adding error.")
            self.presenter?.didAddTodoItemFailed()
        }
    }
    
    func getTodoList() -> [DBModel_TodoItem] {
        return self._todoItemManager.getAll()
    }
    
    func getTodoById(_ id: String) -> DBModel_TodoItem? {
        return self.getTodoList().filter{ $0.id == id }.first
    }
    
    func fetchTodoList() {
        let items = self.getTodoList()
        self.presenter?.didReceiveTodoList(todoList: TodoItemAssembler.convertToDTOList(from: items))
    }
    
    func updateItemStatus(with id: String, callBack: Bool) {
        if let _ = self._todoItemManager.updateItemStatus(with: id) {
            print("Edited item with name \(id) successfully.")
            if callBack {
                self.presenter?.didEditTodoItemSuccess()
            }
        } else {
            print("Editing item with id \(id) error.")
            if callBack {
                self.presenter?.didEditTodoItemFailed()
            }
        }
    }
    
    func deleteItem(with id: String, callBack: Bool) {
        if self._todoItemManager.deleteTodoItem(with: id) {
            print("Deleted item with id \(id) successfully.")
            if callBack {
                self.presenter?.didDeleteTodoItemSuccess()
            }
        } else {
            print("Deleting item with id \(id) error.")
            if callBack {
                self.presenter?.didDeleteTodoItemFailed()
            }
        }
    }
    
    func deleteItems(with ids: [String]) {
        for id in ids {
            self.deleteItem(with: id, callBack: false)
        }
        
        print("Deleted todo list done.")
        self.presenter?.didDeleteTodoList()
    }
    
    func toggleItems(with ids: [String]) {
        for id in ids {
            self.updateItemStatus(with: id, callBack: false)
        }
        
        print("Toggled todo list done.")
        self.presenter?.didToggleTodoList()
    }
}
