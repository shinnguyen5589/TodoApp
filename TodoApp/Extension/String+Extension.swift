//
//  String+Extension.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

import Foundation

extension String {
    public func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
}
