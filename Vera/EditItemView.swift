//
//  EditItemView.swift
//  Vera
//
//  Created by Justin Cabral on 12/19/20.
//

import SwiftUI

struct EditItemView: View {
    
    @EnvironmentObject var dataController: DataController
    
    @State private var title: String
    @State private var detail: String
    @State private var priority: Int
    @State private var completed: Bool
    
    let item: Item
    
    init(item: Item) {
        self.item = item
        
        _title = State(wrappedValue: item.itemTitle)
        _detail = State(wrappedValue: item.itemDetail)
        _priority = State(wrappedValue: Int(item.priority))
        _completed = State(wrappedValue: item.completed)
    }
    
    var body: some View {
        
        Form {
            Section(header: Text("Basic settings")) {
                TextField("Item Name:", text: $title.onChange(update))
                TextField("Description:", text: $detail.onChange(update))
            }
            
            Section(header: Text("Priority")) {
                Picker("Priority", selection: $priority.onChange(update)) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("Height").tag(3)
                }
            }
            
            Section {
                Toggle("Mark Class Finished", isOn: $completed.onChange(update))
            }
            
        }
        .navigationTitle("Edit Item")
        .onDisappear(perform: dataController.save)

    }
    
    func update() {
        item.project?.objectWillChange.send()
        
        item.title = title
        item.detail = detail
        item.priority = Int16(priority)
        item.completed = completed
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(item: Item.example)
    }
}
