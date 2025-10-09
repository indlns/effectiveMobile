//
//  NSObject.swift
//  todoapp
//
//  Created by Евгений Овчинников on 07.10.2025.
//

import Foundation

extension NSObjectProtocol {
    @discardableResult
    func apply(_ closure: (Self) -> () ) -> Self {
    { closure(self) } ()
        return self
    }
}
