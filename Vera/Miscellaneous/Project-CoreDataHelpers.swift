//
//  Project-CoreDataHelpers.swift
//  Vera
//
//  Created by Justin Cabral on 12/19/20.
//

import Foundation

extension Project {
    
    static let colors = ["Pink", "Purple", "Red", "Orange", "Gold", "Green", "Teal", "Light Blue", "Dark Blue", "Midnight", "Dark Gray", "Gray"]
    
    var projectTitle: String {
        title ?? NSLocalizedString("Class", comment: "The title of the class")
    }
    
    var projectDetail: String {
        detail ?? ""
    }
    
    var projectColor: String {
        color ?? "Light Blue"
    }
    
    var projectFinishDate: Date {
        finishDate ?? Date()
    }
    
    var projectStartDate: Date {
        creationDate ?? Date()
    }
    
    var projectItems: [Item] {
        items?.allObjects as? [Item] ?? []
    }
    
    var projectItemsDefaultSorted: [Item] {
    
        projectItems.sorted { first, second in
            
            if first.completed == false {
                if second.completed == true {
                    return true
                }
            }
            else if first.completed == true {
                if second.completed == false {
                    return false
                }
            }
            
            if first.priority > second.priority {
                return true
            }
            else if first.priority < second.priority {
                return false
            }
            
            return first.itemCreationDate < second.itemCreationDate
        }
    }
    
    var completionAmount: Double {
        let originalItems = items?.allObjects as? [Item] ?? []
        guard originalItems.isEmpty == false else { return 0 }
        
        let completedItems = originalItems.filter(\.completed)
        return Double(completedItems.count) / Double(originalItems.count)
    }
    
    var progressAmount: Double {
        let today = Date.dayNumber
        let end = Date.numberForDate(finishDate ?? Date().addingTimeInterval(86000))
        print("\(today / end)")
        return today / end
    }
    
    static var example: Project {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let project = Project(context: viewContext)
        project.title = "Example Class"
        project.detail = "This is an example class"
        project.closed = true
        project.creationDate = Date()
        project.finishDate = Date().addingTimeInterval(86000)
        
        return project
    }
    
    func projectItems(using sortOrder: Item.SortOrder) -> [Item] {
        switch sortOrder {
        case .title:
            return projectItems.sorted(by: \Item.itemTitle)
        case .creationDate:
            return projectItems.sorted(by: \Item.itemCreationDate)
        case .dueDate:
            return projectItems.sorted(by: \Item.itemDueDate)
        case .optimized:
            return projectItemsDefaultSorted
        }
    }

}
