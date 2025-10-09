//
//  ToDoModel.swift
//  todoapp
//
//  Created by Евгений Овчинников on 08.10.2025.
//

import Foundation

struct ToDoModel: Decodable {
    let id: Int
    let todo: String
    let completed: Bool
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case id, todo, completed
        case userID = "userId"
    }
    
    init(id: Int,
         todo: String,
         completed: Bool,
         userID: Int) {
        self.id = id
        self.todo = todo
        self.completed = completed
        self.userID = userID
    }
}
