//
//  EditProjectView.swift
//  Vera
//
//  Created by Justin Cabral on 12/19/20.
//

import SwiftUI

struct EditProjectView: View {
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String
    @State private var detail: String
    @State private var color: String
    @State private var startDate: Date
    @State private var finishDate: Date
    @State private var showingDeleteConfirm = false
    
    
    let project: Project
    let colorColumns = [ GridItem(.adaptive(minimum: 44)) ]
    let FUTURE_DATE: Double = 900000000000000000

    
    init(project: Project) {
        self.project = project
        
        _title = State(wrappedValue: project.projectTitle)
        _detail = State(wrappedValue: project.projectDetail)
        _color = State(wrappedValue: project.projectColor)
        _startDate = State(wrappedValue: project.projectStartDate)
        _finishDate = State(wrappedValue: project.projectFinishDate)
    }
    
    var body: some View {
        Form {
            
            Section(header: Text("Basic description")) {
                TextField("Class name", text: $title.onChange(update))
                TextField("Example: Fall 2020 ", text: $detail.onChange(update))
            }
            
            Section(header: Text("Start - Finish Date")) {
                DatePicker(selection: $startDate.onChange(update), in: ...Date().addingTimeInterval(TimeInterval(FUTURE_DATE)), displayedComponents: .date) {
                    Text("Start Date")
                }
                
                DatePicker(selection: $finishDate.onChange(update), in: ...Date().addingTimeInterval(TimeInterval(FUTURE_DATE)), displayedComponents: .date) {
                    Text("Finish Date")
                }
                
            }
            
            Section(header: Text("Class color")) {
                LazyVGrid(columns: colorColumns) {
                    ForEach(Project.colors, id: \.self) { item in
                        ZStack {
                            Color(item)
                                .aspectRatio(1, contentMode: .fit)
                                .cornerRadius(6)
                            
                            if item == color {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.white)
                                    .font(.title)
                            }
                        }
                        .onTapGesture {
                            color = item
                            update()
                        }
                    }
                }
                .padding(.vertical)
            }
            
            Section(footer: Text("Finishing a class moves it from Current to Finished tab; deleting it removes the class entirely.")) {
                Button(project.closed ? "Reopen this class" : "Finish this class") {
                    project.closed.toggle()
                    update()
                }
                
                Button("Delete this class") {
                    showingDeleteConfirm.toggle()
                }
                .accentColor(.red)
            }
            
            
        }
        .navigationTitle("Edit Class")
        .onDisappear(perform: dataController.save)
        .alert(isPresented: $showingDeleteConfirm) {
            Alert(title: Text("Delete Class?"),
                  message: Text("Are you sure you want to delete this class? It will remove all the items it contains."),
                  primaryButton: .default(Text("Delete"), action: delete),
                  secondaryButton: .cancel()
            )
        }
    }
    
    func update() {
        project.objectWillChange.send()
        
        project.title = title
        project.detail = detail
        project.color = color
        project.creationDate = startDate
        project.finishDate = finishDate
                
    }
    
    func delete() {
        dataController.delete(project)
        presentationMode.wrappedValue.dismiss()
    }
}

struct EditProjectView_Previews: PreviewProvider {
    static var previews: some View {
        EditProjectView(project: Project.example)
    }
}
