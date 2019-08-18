//
//  TodoItemManager.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

open class TodoItemManager: NSObject, TodoItemManaging {
    
    private func getTodoItem(with id: String) -> DB_TodoItem? {
        guard let realm = Realm.createAndLogIfFail() else { return nil }
        
        let predicate = NSPredicate(format: "id == %@", id)
        return realm.objects(DB_TodoItem.self).filter(predicate).first
    }
    
    public func getAll() -> [DBModel_TodoItem] {
        guard let realm = Realm.createAndLogIfFail() else { return [] }
        
        let dbObjects = realm.objects(DB_TodoItem.self)
            .sorted(byKeyPath: DB_TodoItem.Property.localCreatedAt.rawValue, ascending: false).toArray(ofType: DB_TodoItem.self) as [DB_TodoItem]
        return TodoItemAssembler.convertToDBModelList(from: dbObjects)
    }
    
    public func add(name: String) -> DBModel_TodoItem? {
        guard let realm = Realm.createAndLogIfFail() else { return nil }
        let dbObject = DB_TodoItem(name)
        
        Realm.writeAndLogIfFail(realm) {
            realm.add(dbObject)
        }
        return TodoItemAssembler.convertToDBModel(from: dbObject)
    }
    
    public func deleteTodoItem(with id: String) -> Bool {
        guard let realm = Realm.createAndLogIfFail() else { return false }
        guard let todoItem = self.getTodoItem(with: id) else { return false }
        
        Realm.writeAndLogIfFail(realm) {
            realm.delete(todoItem)
        }
        
        return true
    }
    
    public func deleteAllTodoList() {
        guard let realm = Realm.createAndLogIfFail() else { return }
        
        let dbObjects = realm.objects(DB_TodoItem.self)
            .sorted(byKeyPath: DB_TodoItem.Property.localCreatedAt.rawValue, ascending: false).toArray(ofType: DB_TodoItem.self) as [DB_TodoItem]
        for dbObject in dbObjects {
            Realm.writeAndLogIfFail(realm) {
                realm.delete(dbObject)
            }
        }
    }
    
    public func updateItemStatus(with id: String) -> DBModel_TodoItem? {
        guard let realm = Realm.createAndLogIfFail() else { return nil }
        guard let dbObject = self.getTodoItem(with: id)  else { return nil }
        
        Realm.writeAndLogIfFail(realm) {
            dbObject.isDone = !dbObject.isDone
        }
        return TodoItemAssembler.convertToDBModel(from: dbObject)
    }
}
