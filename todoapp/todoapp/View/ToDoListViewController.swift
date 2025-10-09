//
//  ViewController.swift
//  todoapp
//
//  Created by Евгений Овчинников on 07.10.2025.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    private lazy var tableView: UITableView = UITableView()
    private lazy var searchController: UISearchController = UISearchController()
    
    private var toDoListViewModel: ToDoListViewModel!
    private var dataSource : ToDoListTableViewDataSource<ToDoListCell, ToDoModel>?
    private var filteredToDos: [ToDoModel] = []
    private var isSearching: Bool = false
    
    // MARK: - Life Cycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callToViewModelForUIUpdate()
        addSubviews()
        setupTableView()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupTableView() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        tableView.register(ToDoListCell.self, forCellReuseIdentifier: "ToDoListCell")
    }
    
    func callToViewModelForUIUpdate() {
        self.toDoListViewModel = ToDoListViewModel()
        self.toDoListViewModel.bindEmployeeViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource() {
        guard let todos = self.toDoListViewModel.toDoData?.todos else { return }
        self.dataSource = ToDoListTableViewDataSource(cellIdentifier: "ToDoListCell",
                                                      items: todos,
                                                      configureCell: { (cell, todos) in
            cell.configure(with: todos)
        })
        
        DispatchQueue.main.async {
            self.tableView.delegate = self.dataSource
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }
}

extension ToDoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased(), !text.isEmpty else {
            isSearching = false
            filteredToDos = []
            tableView.reloadData()
            return
        }
        
        isSearching = true
        filteredToDos = toDoListViewModel.toDoData?.todos.filter { todo in
            todo.todo.lowercased().contains(text)
        } ?? []
        tableView.reloadData()
    }
}
