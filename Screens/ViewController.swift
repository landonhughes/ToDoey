//
//  ViewController.swift
//  ToDoey
//
//  Created by Landon Hughes on 2/13/22.
//

import UIKit

class ViewController: UIViewController {

    private var todos: [ToDoItem]!
    private let tableView = UITableView(frame: .zero)
    private var todoDataSource: TodoDiffableDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todos = StorageManager.shared.getAllItems()
        configureDataSource()
        createInitialSnapshot()
        configureViewController()
        configureTableView()
    }
    
    private func configureDataSource() {
         todoDataSource = TodoDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, todoItem in
             let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
             cell.textLabel?.text = todoItem.name
             return cell
         })
        todoDataSource.delegate = self
    }
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "ToDoey"
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToDo))
        navigationItem.rightBarButtonItem = plusButton
        
    }
    @objc func addToDo() {
        let alert = UIAlertController(title: "Add To-Do", message: "Whatcha need to do?", preferredStyle: .alert)
        alert.addTextField()
        
        let addToDoAction = UIAlertAction(title: "Add", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            let textField = alert.textFields![0]
            if textField.text!.trimmingCharacters(in: .whitespaces).isEmpty {
                return
            }
            StorageManager.shared.createItem(name: textField.text!)
            self.updateDatasource()
        })
        alert.addAction(addToDoAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(alert, animated: true, completion: nil)
    }

    private func createInitialSnapshot() {
        var snapshot = todoDataSource.snapshot()
        snapshot.appendSections([.first])
        snapshot.appendItems(todos)
        todoDataSource.apply(snapshot, animatingDifferences: false, completion: nil)
    }
    private func updateDatasource() {
        var snapshot = todoDataSource.snapshot()
        if let currentTodoItems = StorageManager.shared.getAllItems() {
            snapshot.appendItems(currentTodoItems, toSection: .first)
        }
        todoDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    

}

extension ViewController: Deletable {
    func didDeleteOnSwipe(todoItem: ToDoItem) {
        var snapshot = todoDataSource.snapshot()
        snapshot.deleteItems([todoItem])
        todoDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}
