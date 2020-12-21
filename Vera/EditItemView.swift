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
    @State private var dueDate: Date
    
    let item: Item
    let FUTURE_DATE: Double = 900000000000000000
    
    init(item: Item) {
        self.item = item
        
        _title = State(wrappedValue: item.itemTitle)
        _detail = State(wrappedValue: item.itemDetail)
        _priority = State(wrappedValue: Int(item.priority))
        _completed = State(wrappedValue: item.completed)
        _dueDate = State(wrappedValue: item.itemDueDate)
    }
    
    var body: some View {
        
        Form {
            Section(header: Text("Basic description")) {
                TextField("Item Name:", text: $title.onChange(update))
                TextField("Description:", text: $detail.onChange(update))
            }
            
            Section(header: Text("Due Date")) {
                DatePicker(selection: $dueDate.onChange(update), in: ...Date().addingTimeInterval(TimeInterval(FUTURE_DATE)), displayedComponents: .date) {
                    Text("Due date")
                }
            }
            
            Section(header: Text("Priority")) {
                Picker("Priority", selection: $priority.onChange(update)) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("High").tag(3)
                }.pickerStyle(SegmentedPickerStyle())
                
                HStack {
                    Spacer()
                    Image(systemName: "circlebadge.fill")
                        .foregroundColor(Color(item.project?.projectColor ?? "Light Blue"))
                    Spacer()
                    Spacer()
                    Image(systemName: "diamond.fill")
                        .foregroundColor(Color(item.project?.projectColor ?? "Light Blue"))
                    Spacer()
                    Spacer()
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(Color(item.project?.projectColor ?? "Red"))
                    Spacer()
                }
            }
            
            Section {
                Toggle("Mark as complete", isOn: $completed.onChange(update))
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
        item.dueDate = dueDate
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(item: Item.example)
    }
}
