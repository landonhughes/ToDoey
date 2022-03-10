//
//  ToDoItem+CoreDataProperties.swift
//  ToDoey
//
//  Created by Landon Hughes on 3/10/22.
//
//

import Foundation
import CoreData


extension ToDoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }

    @NSManaged public var name: String?

}

extension ToDoItem : Identifiable {

}
