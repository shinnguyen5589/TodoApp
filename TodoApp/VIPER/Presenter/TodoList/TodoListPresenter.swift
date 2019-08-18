//
//  TodoListPresenter.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

class TodoListPresenter: TodoListPresenterInputProtocol {
    
    weak var view: (TodoListPresenterOutputProtocol & TodoListViewProtocol)?
    var wireframe: TodoListWireframeProtocol?
    var interactor: TodoListInteractorInputProtocol?
    
    private var _todoList: [DTO_TodoItem] = []
    
    func viewDidLoad() {
        self.interactor?.fetchTodoList()
    }
    
    func getTodoListCount(with filter: FilterType) -> Int {
        return self.getTodoList(with: filter).count
    }
    
    func getTodoItem(with filter: FilterType, atIndex: Int) -> ViewModel_TodoItem {
        let todoList = self.getTodoList(with: filter)
        return todoList[atIndex]
    }
    
    func didEndEditing(with name: String?) {
        guard let name = name?.trim() else { return }
        if name == "" {
            self.view?.presentEnterEmptyNamePopup()
            return
        }
        
        self.interactor?.addTodoItem(name: name)
    }

    func didTapCheckBox(with id: String) {
        let item = self._todoList.filter{ $0.id == id }.first
        if let item = item {
            item.isDone = !item.isDone
        }
        self.interactor?.updateItemStatus(with: id, callBack: true)
    }
    
    func didTapDeleteButton(with id: String) {
        self.view?.presentDeleteItemPopup(with: id)
    }
    
    func didConfirmDeleteTodo(with id: String) {
        self.interactor?.deleteItem(with: id, callBack: true)
    }
    
    func didTapToggleAllButton(with filter: FilterType) {
        let todoList = self.getTodoList(with: filter)
        self.interactor?.toggleItems(with: todoList.compactMap{ $0.id })
    }
    
    func didTapClearButton(with filter: FilterType) {
        self.view?.presentClearItemsPopup(with: filter)
    }
    
    func didConfirmClearTodoList(with filter: FilterType) {
        let todoList = self.getTodoList(with: filter)
        self.interactor?.deleteItems(with: todoList.compactMap{ $0.id })
    }
    
    private func getTodoList(with filter: FilterType) -> [ViewModel_TodoItem] {
        var todoList = TodoItemAssembler.convertToViewModelList(from: self._todoList) // all
        if filter == .Done {
            todoList = todoList.filter{ $0.isDone }
        } else if filter == .Active {
            todoList = todoList.filter{ !$0.isDone }
        }
        
        return todoList
    }
}

extension TodoListPresenter: TodoListInteractorOutputProtocol {
    
    func didReceiveTodoList(todoList: [DTO_TodoItem]) {
        self._todoList = todoList
        self.view?.updateTodoList()
    }
    
    func didToggleTodoList() {
        self.interactor?.fetchTodoList()
    }
    
    func didDeleteTodoList() {
        self.interactor?.fetchTodoList()
    }
    
    func didAddTodoItemSuccess() {
        self.interactor?.fetchTodoList()
        self.view?.presentAddedSuccessPopup()
        self.view?.scrollToTop()
    }
    
    func didAddTodoItemFailed() {
        self.interactor?.fetchTodoList()
        self.view?.presentAddedErrorPopup()
    }
    
    func didEditTodoItemSuccess() {
        self.view?.updateTodoList()
    }
    
    func didEditTodoItemFailed() {
        //
    }
    
    func didDeleteTodoItemSuccess() {
        self.interactor?.fetchTodoList()
    }
    
    func didDeleteTodoItemFailed() {
        //
    }
}
