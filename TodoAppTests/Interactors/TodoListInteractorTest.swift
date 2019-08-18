//
//  TodoListInteractorTest.swift
//  TodoAppTests
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

import XCTest
import Foundation

class TodoListInteractorTest: XCTestCase {
    
    override func setUp() {
        //
    }
    
    override func tearDown() {
        //
    }
    
    func testTodoListIsDefaultEmpty() {
        let interactor = TodoListInteractor(todoItemManager: TodoItemManagerMock())
        XCTAssertTrue(interactor.getTodoList().isEmpty)
    }
    
    func testTodoListCoutAfterAddedSeveralItems() {
        let interactor = TodoListInteractor(todoItemManager: TodoItemManagerMock())
        for i in 1...5 {
            interactor.addTodoItem(name: "Todo \(i)")
        }
        
        XCTAssertEqual(5, interactor.getTodoList().count)
    }
    
    func testEditTodoItem() {
        let interactor = TodoListInteractor(todoItemManager: TodoItemManagerMock())
        for i in 1...5 {
            interactor.addTodoItem(name: "Todo \(i)")
        }
        
        let item = interactor.getTodoList()[3]
        interactor.updateItemStatus(with: item.id, callBack: false)
        
        if let _item = interactor.getTodoById(item.id) {
            XCTAssertEqual(true, _item.isDone)
        }
    }
    
    func testDeleteSomeTodoItems() {
        let interactor = TodoListInteractor(todoItemManager: TodoItemManagerMock())
        for i in 1...5 {
            interactor.addTodoItem(name: "Todo \(i)")
        }
        
        let item1 = interactor.getTodoList()[1]
        let item2 = interactor.getTodoList()[3]
        
        interactor.deleteItem(with: item1.id, callBack: false)
        interactor.deleteItem(with: item2.id, callBack: false)
        
        XCTAssertEqual(3, interactor.getTodoList().count)
    }
    
    func testDeleteAllTodoItems() {
        let interactor = TodoListInteractor(todoItemManager: TodoItemManagerMock())
        for i in 1...5 {
            interactor.addTodoItem(name: "Todo \(i)")
        }
        
        let ids = interactor.getTodoList().compactMap{ $0.id }
        interactor.deleteItems(with: ids)
        
        XCTAssertEqual(0, interactor.getTodoList().count)
    }
    
    func testToggleAllTodoItems() {
        let interactor = TodoListInteractor(todoItemManager: TodoItemManagerMock())
        for i in 1...5 {
            interactor.addTodoItem(name: "Todo \(i)")
        }
        
        let ids = interactor.getTodoList().compactMap{ $0.id }
        interactor.toggleItems(with: ids)
        
        var count: Int = 0
        for item in interactor.getTodoList() {
            if item.isDone {
                count += 1
            }
        }
        XCTAssertEqual(5, interactor.getTodoList().count)
    }
}
