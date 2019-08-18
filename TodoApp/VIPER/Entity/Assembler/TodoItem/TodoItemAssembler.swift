//
//  TodoItemAssembler.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

class TodoItemAssembler {
    
    // From DBModel object to DTO object
    static func convertToDTOList(from dbModels: [DBModel_TodoItem]) -> [DTO_TodoItem] {
        return dbModels.map({ (dbModel) -> DTO_TodoItem in
            return DTO_TodoItem(id: dbModel.id, name: dbModel.name, isDone: dbModel.isDone)
        })
    }
    
    static func convertToDTO(from dbModel: DBModel_TodoItem) -> DTO_TodoItem {
        return DTO_TodoItem(id: dbModel.id, name: dbModel.name, isDone: dbModel.isDone)
    }
    
    // From DTO object to Viewmodel object
    static func convertToViewModelList(from dtoObjects: [DTO_TodoItem]) -> [ViewModel_TodoItem] {
        return dtoObjects.map({ (dtoObject) -> ViewModel_TodoItem in
            return ViewModel_TodoItem(id: dtoObject.id, name: dtoObject.name, isDone: dtoObject.isDone)
        })
    }
    
    static func convertToViewModel(from dtoOject: DTO_TodoItem) -> ViewModel_TodoItem {
        return ViewModel_TodoItem(id: dtoOject.id, name: dtoOject.name, isDone: dtoOject.isDone)
    }
}
