//
//  TodoItemTextServiceMock.swift
//  TodoAppTests
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

import Foundation

class TodoItemTextServiceMock: NSObject, TodoTextServiceProtocol {
    
    func reset() {
        // TODO: -
    }
    
    func importTexts(dictionary: [String : Any]) {
        // TODO: -
    }
    
    func text(key: Keys) -> String {
        // TODO: -
        return ""
    }
    
    func text(key: String) -> String {
        // TODO: -
        return ""
    }
    
    func hasEmptyValue(key: String) -> Bool {
        // TODO: -
        return true
    }
    
    func text(key: String, fallback: String) -> String {
        // TODO: -
        return ""
    }
}
