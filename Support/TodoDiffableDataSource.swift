//
//  TodoDiffableDataSource.swift
//  ToDoey
//
//  Created by Landon Hughes on 3/9/22.
//

import Foundation
import UIKit

enum Section { case first }

protocol Deletable {
    func didDeleteOnSwipe(todoItem: ToDoItem)
}
class TodoDiffableDataSource: UITableViewDiffableDataSource<Section,ToDoItem> {
    
    var delegate: Deletable?
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let todoItems = StorageManager.shared.getAllItems() else { return }
        if editingStyle == .delete {
            let todoToDelete = todoItems[indexPath.row]
            StorageManager.shared.deleteItem(item: todoToDelete)
            delegate?.didDeleteOnSwipe(todoItem: todoToDelete)
        }
        
    }
}
