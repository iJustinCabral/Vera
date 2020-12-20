//
//  ProjectsView.swift
//  Vera
//
//  Created by Justin Cabral on 12/18/20.
//

import SwiftUI

struct ProjectView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var dataController: DataController
    
    @State private var showingSortOrder = false
    @State private var sortOrder = Item.SortOrder.optimized
    
    static let classesTag: String? = "Classes"
    static let finishedTag: String? = "Finished"
    
    let showClosedProjects: Bool
    let projects: FetchRequest<Project>
    
    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects
        
        projects = FetchRequest<Project>(entity: Project.entity(),
                                         sortDescriptors: [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)],
                                         predicate: NSPredicate(format: "closed = %d", showClosedProjects))
    }
    
    var body: some View {
        NavigationView {
            Group {
                if projects.wrappedValue.isEmpty {
                    Text("There's nothing here right now ")
                        .foregroundColor(.secondary)
                } else {
            
                    List {
                        ForEach(projects.wrappedValue) { project in
                            Section(header: ProjectHeaderView(project: project)) {
                                ForEach(project.projectItems(using: sortOrder)) { item in
                                    ItemRowView(project: project, item: item)
                                }
                                .onDelete { offsets in
                                    let allItems = project.projectItems(using: sortOrder)
                                                                
                                    for offset in offsets {
                                        let item = allItems[offset]
                                        dataController.delete(item)
                                    }
                                                                
                                    dataController.save()
                                }
                                
                                if showClosedProjects == false {
                                    Button {
                                            withAnimation {
                                                let item = Item(context: managedObjectContext)
                                                item.project = project
                                                item.creationDate = Date()
                                                item.dueDate = Date().addingTimeInterval(86000)
                                                dataController.save()
                                            }
                                        } label: {
                                            Label("Add New Item", systemImage: "plus")
                                        }
                                }
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationTitle(showClosedProjects ? "Class Archive" : "Classes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                
                    if showClosedProjects == false {
                        Button {
                            withAnimation {
                                let project = Project(context: managedObjectContext)
                                project.closed = false
                                project.creationDate = Date()
                                dataController.save()
                            }
                        } label : {
                            Label("Add Class", systemImage: "plus")
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingSortOrder.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "line.horizontal.3.decrease.circle.fill")
                                .aspectRatio(contentMode: .fit)
                                .imageScale(.large)
                            Text("Sort")
                        }
                    }
                }
            }
            .actionSheet(isPresented: $showingSortOrder) {
                ActionSheet(title: Text("Sort items"), message: nil, buttons: [
                    .default(Text("Optimized")) { sortOrder = .optimized },
                    .default(Text("Creation Date")) { sortOrder = .creationDate },
                    .default(Text("Due Date")) { sortOrder = .dueDate },
                    .default(Text("Title")) { sortOrder = .title }
                ])
            }
            
            // For support for landscape and iPad
            SelectSomethingView()
        }
    }
    
}

struct ProjectsView_Previews: PreviewProvider {
    
    static var dataController = DataController.preview
    
    static var previews: some View {
        ProjectView(showClosedProjects: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
