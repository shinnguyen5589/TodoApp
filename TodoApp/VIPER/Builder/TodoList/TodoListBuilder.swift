//
//  TodoListBuilder.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

class TodoListBuilder: TodoListBuilderProtocol {
    func createTodoList() -> (UIViewController & TodoListViewProtocol) {
        let view = TodoListViewController(todoTextService: AppComponents.todoTextService)
        let presenter = TodoListPresenter()
        let interactor = TodoListInteractor(todoItemManager: AppComponents.todoItemManager)
        let wireframe = TodoListWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        return view
    }
}
