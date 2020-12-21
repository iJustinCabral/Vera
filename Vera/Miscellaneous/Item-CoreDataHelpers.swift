//
//  Item-CoreDataHelpers.swift
//  Vera
//
//  Created by Justin Cabral on 12/19/20.
//

import Foundation

extension Item {

    enum SortOrder {
        case optimized, title, creationDate, dueDate
    }

    var itemTitle: String {
        title ?? NSLocalizedString("New Item", comment: "Create a new item")
    }

    var itemDetail: String {
        detail ?? ""
    }

    var itemCreationDate: Date {
        creationDate ?? Date()
    }

    var itemDueDate: Date {
        dueDate ?? Date().addingTimeInterval(86000)
    }

    static var example: Item {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext

        let item = Item(context: viewContext)
        item.title =  "Example Item"
        item.detail = "This is an example item"
        item.priority = 3
        item.creationDate = Date()
        item.dueDate = Date()

        return item
    }
}
