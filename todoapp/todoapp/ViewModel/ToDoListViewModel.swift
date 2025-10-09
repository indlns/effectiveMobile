//
//  ToDoListViewModel.swift
//  todoapp
//
//  Created by Евгений Овчинников on 08.10.2025.
//

import Foundation

class ToDoListViewModel: NSObject {
    
    private var apiService: APIService!
    
    private(set) var toDoData: ToDoListModel? {
        didSet {
            self.bindEmployeeViewModelToController()
        }
    }
    
    var bindEmployeeViewModelToController: (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIService()
        callFuncToGetEmpData()
    }
    
    func callFuncToGetEmpData() {
        self.apiService.getApiData { [weak self] toDoData in
            self?.toDoData = toDoData
        }
    }
}
