//
//  ToDoListModel.swift
//  todoapp
//
//  Created by Евгений Овчинников on 08.10.2025.
//

import Foundation

struct ToDoListModel: Decodable {
    let todos: [ToDoModel]
    let total, skip, limit: Int
}
