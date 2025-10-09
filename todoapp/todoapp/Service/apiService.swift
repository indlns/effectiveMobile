//
//  apiService.swift
//  todoapp
//
//  Created by Евгений Овчинников on 08.10.2025.
//

import Foundation

class APIService: NSObject {
    
    private let sourcesURL = URL(string: "https://dummyjson.com/todos")!
    
    func getApiData(completion : @escaping (ToDoListModel) -> ()) {
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let empData = try jsonDecoder.decode(ToDoListModel.self,
                                                         from: data)
                    completion(empData)
                    
                } catch {
                    print(error.localizedDescription)
                }
                
            }
        }.resume()
    }
}
