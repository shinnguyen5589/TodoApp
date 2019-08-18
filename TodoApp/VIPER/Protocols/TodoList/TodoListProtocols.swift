//
//  TodoListProtocols.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

import UIKit

enum FilterType: String {
    case All
    case Done
    case Active
}

// BUILDER
protocol TodoListBuilderProtocol: BaseBuilderProtocol {
    func createTodoList() -> (UIViewController & TodoListViewProtocol)
}

// WIREFRAME
protocol TodoListWireframeProtocol: BaseWireframeProtocol {
    //
}

// VIEW
protocol TodoListViewProtocol: BaseViewProtocol {  // Conformed by View
    ///
    var presenter: TodoListPresenterInputProtocol? { get set } // strong reference
}

// PRESENTER
protocol TodoListPresenterInputProtocol: BasePresenterProtocol { // Conformed by Presenter
    ///
    var view: (TodoListPresenterOutputProtocol & TodoListViewProtocol)? { get set } // weak reference
    var wireframe: TodoListWireframeProtocol? { get set } // strong reference
    var interactor: TodoListInteractorInputProtocol? { get set } // strong reference
    
    // View -> Presenter
    func viewDidLoad()
    
    func getTodoListCount(with filter: FilterType) -> Int
    func getTodoItem(with filter: FilterType, atIndex: Int) -> ViewModel_TodoItem
    
    /// IBActions
    func didEndEditing(with name: String?)
    func didTapCheckBox(with id: String)
    func didTapDeleteButton(with id: String)
    func didConfirmDeleteTodo(with id: String)
    func didTapToggleAllButton(with filter: FilterType)
    func didTapClearButton(with filter: FilterType)
    func didConfirmClearTodoList(with filter: FilterType)
}

protocol TodoListPresenterOutputProtocol { // Conformed by View
    func updateTodoList()
    func scrollToTop()
    func presentAddedSuccessPopup()
    func presentAddedErrorPopup()
    func presentEnterEmptyNamePopup()
    func presentDeleteItemPopup(with id: String)
    func presentClearItemsPopup(with filter: FilterType)
}

// INTERACTOR
protocol TodoListInteractorInputProtocol: BaseInteractorProtocol { // Conformed by Interactor
    ///
    var presenter: TodoListInteractorOutputProtocol?  { get set } // weak reference

    func getTodoList() -> [DBModel_TodoItem]
    func getTodoById(_ id: String) -> DBModel_TodoItem?
    func fetchTodoList()
    func addTodoItem(name: String)
    func updateItemStatus(with id: String, callBack: Bool)
    func deleteItem(with id: String, callBack: Bool)
    func deleteItems(with ids: [String])
    func toggleItems(with ids: [String])
}

protocol TodoListInteractorOutputProtocol: class { // Conformed by Presenter
    func didReceiveTodoList(todoList: [DTO_TodoItem])
    func didToggleTodoList()
    func didDeleteTodoList()
    
    func didAddTodoItemSuccess()
    func didAddTodoItemFailed()
    
    func didEditTodoItemSuccess()
    func didEditTodoItemFailed()
    
    func didDeleteTodoItemSuccess()
    func didDeleteTodoItemFailed()
}
