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
    static let archiveTag: String? = "Archive"

    let showClosedProjects: Bool
    let projects: FetchRequest<Project>

    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects

        projects = FetchRequest<Project>(entity: Project.entity(),
                                         sortDescriptors: [NSSortDescriptor(keyPath: \Project.creationDate,
                                                                            ascending: false)],
                                         predicate: NSPredicate(format: "closed = %d", showClosedProjects))
    }

    var classCardView: some View {
        ZStack {
            Color.systemGroupedBackground.edgesIgnoringSafeArea(.all)
        Rectangle()
            .fill(Color.secondaryGroupedBackground)
            .frame(width: 300, height: 260)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.2), radius: 4)
            .overlay(
                VStack {
                    Text("No Classes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Text(showClosedProjects ? "The class archive is empty." : "There are no classes available")
                        .foregroundColor(.secondary)
                }
            )
        }
    }

    var projectsList: some View {
        List {
            ForEach(projects.wrappedValue) { project in
                Section(header: ProjectHeaderView(project: project)) {
                    ForEach(project.projectItems(using: sortOrder)) { item in
                        ItemRowView(project: project, item: item)
                    }
                    .onDelete { offsets in
                        delete(offsets, from: project)
                    }

                    if showClosedProjects == false {
                        Button { addItem(to: project) } label: {
                                Label("Add New Item", systemImage: "plus")
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }

    var trailingToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            if showClosedProjects == false {
                Button(action: addProject) {
                    HStack {
                        Text("Add")
                        Image(systemName: "plus")
                            .aspectRatio(contentMode: .fit)
                            .imageScale(.large)
                    }
                }
            }
        }
    }

    var leadingToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                showingSortOrder.toggle()
            } label: {
                HStack {
                    Image(systemName: "line.horizontal.3.decrease")
                        .aspectRatio(contentMode: .fit)
                        .imageScale(.large)
                    Text("Sort")
                }
            }
        }
    }

    var body: some View {
        NavigationView {
            Group {
                if projects.wrappedValue.isEmpty { classCardView } else { projectsList }
            }
            .navigationTitle(showClosedProjects ? "Class Archive" : "Classes")
            .toolbar {
                trailingToolbarItem
                leadingToolbarItem
            }
            .actionSheet(isPresented: $showingSortOrder) {
                ActionSheet(title: Text("Sort items"), message: nil, buttons: [
                    .default(Text("Optimized")) { sortOrder = .optimized },
                    .default(Text("Creation Date")) { sortOrder = .creationDate },
                    .default(Text("Due Date")) { sortOrder = .dueDate },
                    .default(Text("Title")) { sortOrder = .title },
                    .cancel(Text("Cancel")) { sortOrder = sortOrder }
                ])
            }
            // For support for landscape and iPad
            SelectSomethingView()
        }
    }

    func addProject() {
        withAnimation {
            let project = Project(context: managedObjectContext)
            project.closed = false
            project.creationDate = Date()
            dataController.save()
        }
    }

    func addItem(to project: Project) {
        withAnimation {
            let item = Item(context: managedObjectContext)
            item.project = project
            item.creationDate = Date()
            item.dueDate = Date().addingTimeInterval(86000)
            dataController.save()
        }
    }

    func delete(_ offsets: IndexSet, from project: Project) {
        let allItems = project.projectItems(using: sortOrder)
        for offset in offsets {
            let item = allItems[offset]
            dataController.delete(item)
        }
        dataController.save()
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
