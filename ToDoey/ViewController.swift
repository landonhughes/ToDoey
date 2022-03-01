//
//  ViewController.swift
//  ToDoey
//
//  Created by Landon Hughes on 2/13/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    enum Section {
        case first
    }
    
    struct ToDoModel: Hashable {
        let title: String
    }
    
    var todos: [ToDoModel] = []
    private let tableView = UITableView(frame: .zero)
    var dataSource: UITableViewDiffableDataSource<Section, ToDoModel>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        configureDataSource()
        
    }

    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = model.title
            return cell
        })
    }
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
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
            let textField = alert.textFields![0]
            if let empty = textField.text?.isEmpty {
                if empty {
                    return
                }
                self?.todos.append(ToDoModel(title: textField.text!))
                self?.updateDatasource()
            }
        })
        alert.addAction(addToDoAction)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }

    func updateDatasource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ToDoModel>()
        snapshot.appendSections([.first])
        snapshot.appendItems(todos)
        
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}


