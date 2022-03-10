//
//  StorageManager.swift
//  ToDoey
//
//  Created by Landon Hughes on 3/10/22.
//

import UIKit

class StorageManager {
    
    static let shared = StorageManager()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllItems() -> [ToDoItem]? {
        
        do {
            let items = try context.fetch(ToDoItem.fetchRequest())
            return items
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func createItem(name: String) {
        let newItem = ToDoItem(context: context)
        newItem.name = name
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteItem(item: ToDoItem) {
        context.delete(item)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateItem(item: ToDoItem, newName: String) {
        item.name = newName
    }
}
