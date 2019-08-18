//
//  TodoListViewOutputMock.swift
//  TodoAppTests
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

import Foundation

class TodoListViewOutputMock: NSObject, TodoListPresenterOutputProtocol, TodoListViewProtocol {
   
    var presenter: TodoListPresenterInputProtocol?
    var getPresentEnterEmptyNamePopupGotCalled = false
    var getPresentAddedSuccessPopupGotCalled = false
    var getUpdateTodoListCalled = false
    var getPresentDeleteItemPopupCalled = false
    var getScrollToTopCalled = false
    var getPresentClearItemsPopupCalled = false
    
    func updateTodoList() {
        self.getUpdateTodoListCalled = true
    }
    
    func scrollToTop() {
        self.getScrollToTopCalled = true
    }
    
    func presentDeleteItemPopup(with id: String) {
        self.getPresentDeleteItemPopupCalled = true
    }
    
    func presentClearItemsPopup(with filter: FilterType) {
        self.getPresentClearItemsPopupCalled = true
    }
    
    func presentAddedSuccessPopup() {
        self.getPresentAddedSuccessPopupGotCalled = true
    }
    
    func presentAddedErrorPopup() {
        //
    }
    
    func presentEnterEmptyNamePopup() {
        self.getPresentEnterEmptyNamePopupGotCalled = true
    }
}
