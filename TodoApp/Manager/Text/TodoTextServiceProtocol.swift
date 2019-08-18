//
//  TodoTextServiceProtocol.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

public protocol TodoTextServiceProtocol {
    
    func reset() 
    func importTexts(dictionary: [String: Any])
    func text(key: Keys) -> String
    func text(key: String) -> String
    func hasEmptyValue(key: String) -> Bool
    func text(key: String, fallback: String) -> String
}
