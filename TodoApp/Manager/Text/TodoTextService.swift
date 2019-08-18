//
//  TodoTextService.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

class TodoTextService: NSObject, TodoTextServiceProtocol {
    
    private var texts = [String: String]()
    
    private func serverKey(localKey: Keys) -> String {
        return localKey.rawValue.replacingOccurrences(of: "_", with: ".")
    }
    
    private func localizedKey(localKey: Keys) -> String {
        return localKey.rawValue.replacingOccurrences(of: "_", with: ".")
    }
    
    override init (){
        super.init()
        
        self.reset()
    }
    
    public func reset() {
        texts = [String: String]()
        
        texts[serverKey(localKey: .todo_popup_ok_button)] = "Ok"
        texts[serverKey(localKey: .todo_popup_cancel_button)] = "Cancel"
        texts[serverKey(localKey: .todo_popup_delete_button)] = "Delete"
        texts[serverKey(localKey: .todo_popup_delete_item_message)] = "Do you want to delete this todo?"
        texts[serverKey(localKey: .todo_popup_delete_item_list_message)] = "Do you want to delete these todo items?"
        texts[serverKey(localKey: .todo_popup_plese_enter_name_of_todo_item)] = "Please enter the name of todo."
        texts[serverKey(localKey: .todo_popup_added_successfully)] = "Added successfully."
        texts[serverKey(localKey: .todo_popup_adding_error)] = "Adding error."
        
        texts[serverKey(localKey: .todo_list_title)] = "Todo App"
        texts[serverKey(localKey: .todo_list_text_field_placeholder)] = "Enter todo name here"
        texts[serverKey(localKey: .todo_list_filter_button)] = "Filter"
        texts[serverKey(localKey: .todo_list_toggle_all_button)] = "Toggle All"
        texts[serverKey(localKey: .todo_list_clear_button)] = "Clear"
        texts[serverKey(localKey: .todo_list_all_button)] = "All"
        texts[serverKey(localKey: .todo_list_done_button)] = "Done"
        texts[serverKey(localKey: .todo_list_active_button)] = "Active"
    }
    
    public func importTexts(dictionary: [String: Any]) {
        for(key, value) in dictionary {
            if let text = value as? String {
                texts[key] = text
            }
        }
    }
    
    public func text(key: Keys) -> String {
        if let text = texts[serverKey(localKey: key)] {
            return text
        } else {
            return key.rawValue
        }
    }
    
    public func text(key: String) -> String {
        if let text = texts[key] {
            return text
        } else {
            return key
        }
    }
    
    public func hasEmptyValue(key: String) -> Bool {
        if let text = texts[key] {
            return text.count <= 0
        } else {
            return true
        }
    }
    
    public func text(key: String, fallback: String) -> String {
        if let text = texts[key] {
            return text
        } else {
            return fallback
        }
    }
    
    public static func format(str: String, param1: String) -> String {
        return str.replacingOccurrences(of: "{\(0)}", with: param1)
    }
}
