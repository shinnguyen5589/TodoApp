//
//  TodoListPresenterTest.swift
//  TodoAppTests
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

import XCTest
import Foundation

class TodoListPresenterTest: XCTestCase {
    
    override func setUp() {
        //
    }
    
    override func tearDown() {
        //
    }
    
    func testShowEnterEmptyNamePopup() {
        let presenter = TodoListPresenter()
        let view = TodoListViewOutputMock()
        
        view.presenter = presenter
        presenter.view = view
        
        presenter.didEndEditing(with: " ")
        
        XCTAssertTrue(view.getPresentEnterEmptyNamePopupGotCalled)
    }
    
    func testShowAddSuccessPopup() {
        let presenter = TodoListPresenter()
        let view = TodoListViewOutputMock()
        let interactor = TodoListInteractor(todoItemManager: TodoItemManagerMock())
        
        view.presenter = presenter
        presenter.view = view
        
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        presenter.didEndEditing(with: "To do 1")
        
        XCTAssertTrue(view.getPresentAddedSuccessPopupGotCalled)
    }
    
    func testAddItemFromPresenterToInteractor() {
        let presenter = TodoListPresenter()
        let view = TodoListViewOutputMock()
        let interactor = TodoListInteractor(todoItemManager: TodoItemManagerMock())
        
        view.presenter = presenter
        presenter.view = view
        
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        for i in 1...2 {
            presenter.didEndEditing(with: "To do \(i)")
        }
        
        XCTAssertEqual(2, interactor.getTodoList().count)
    }
    
    func testToggleSecondItemFromPresenterToInteractor() {
        let presenter = TodoListPresenter()
        let view = TodoListViewOutputMock()
        let interactor = TodoListInteractor(todoItemManager: TodoItemManagerMock())
        
        view.presenter = presenter
        presenter.view = view
        
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        for i in 1...2 {
            presenter.didEndEditing(with: "To do \(i)")
        }
        
        presenter.didTapCheckBox(with: interactor.getTodoList()[1].id)
        
        XCTAssertEqual(true, view.getUpdateTodoListCalled)
    }
    
    func testShowDeletePopupWasShowWhenTapDeleteButton() {
        let presenter = TodoListPresenter()
        let view = TodoListViewOutputMock()
        let interactor = TodoListInteractor(todoItemManager: TodoItemManagerMock())
        
        view.presenter = presenter
        presenter.view = view
        
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        for i in 1...5 {
            presenter.didEndEditing(with: "To do \(i)")
        }
        
        presenter.didTapDeleteButton(with: interactor.getTodoList()[interactor.getTodoList().count - 1].id)
        
        XCTAssertEqual(true, view.getPresentDeleteItemPopupCalled)
    }
    
    func testScrollToTopWillBeCalledAfterAddedNewItem() {
        let presenter = TodoListPresenter()
        let view = TodoListViewOutputMock()
        let interactor = TodoListInteractor(todoItemManager: TodoItemManagerMock())
        
        view.presenter = presenter
        presenter.view = view
        
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        presenter.didEndEditing(with: "To do 1")
        
        XCTAssertEqual(true, view.getScrollToTopCalled)
    }
    
    func testShowClearPopupWasShowWhenTapClearButton() {
        let presenter = TodoListPresenter()
        let view = TodoListViewOutputMock()
        let interactor = TodoListInteractor(todoItemManager: TodoItemManagerMock())
        
        view.presenter = presenter
        presenter.view = view
        
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        for i in 1...3 {
            presenter.didEndEditing(with: "To do \(i)")
        }
        
        presenter.didTapClearButton(with: .Done)
        
        XCTAssertEqual(true, view.getPresentClearItemsPopupCalled)
    }
    
    func testToggleAllTodoItem() {
        let presenter = TodoListPresenter()
        let view = TodoListViewOutputMock()
        let interactor = TodoListInteractor(todoItemManager: TodoItemManagerMock())
        
        view.presenter = presenter
        presenter.view = view
        
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        for i in 1...10 {
            presenter.didEndEditing(with: "To do \(i)")
        }
        
        presenter.didTapToggleAllButton(with: .All)
        
        XCTAssertEqual(10, interactor.getTodoList().filter{ $0.isDone == true }.count)
    }
    
    func testTapConfirmDeleteButton() {
        let presenter = TodoListPresenter()
        let view = TodoListViewOutputMock()
        let interactor = TodoListInteractor(todoItemManager: TodoItemManagerMock())
        
        view.presenter = presenter
        presenter.view = view
        
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        for i in 1...3 {
            presenter.didEndEditing(with: "To do \(i)")
        }
        
        presenter.didConfirmDeleteTodo(with: interactor.getTodoList()[1].id)
        
        XCTAssertEqual(2, interactor.getTodoList().count)
        XCTAssertEqual(true, view.getUpdateTodoListCalled)
    }
    
    func testTapConfirmClearButton() {
        let presenter = TodoListPresenter()
        let view = TodoListViewOutputMock()
        let interactor = TodoListInteractor(todoItemManager: TodoItemManagerMock())
        
        view.presenter = presenter
        presenter.view = view
        
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        for i in 1...10 {
            presenter.didEndEditing(with: "To do \(i)")
        }
        
        for i in 2...5 {
            presenter.didTapCheckBox(with: interactor.getTodoList()[i].id)
        }
        
        presenter.didConfirmClearTodoList(with: .Done)
        
        XCTAssertEqual(6, interactor.getTodoList().count)
        XCTAssertEqual(true, view.getUpdateTodoListCalled)
    }
}

