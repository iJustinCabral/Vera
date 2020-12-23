//
//  HomeView.swift
//  Vera
//
//  Created by Justin Cabral on 12/18/20.
//

import SwiftUI
import CoreData

struct HomeView: View {

    @EnvironmentObject var dataController: DataController
    @FetchRequest(entity: Project.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Project.title, ascending: true)],
                  predicate: NSPredicate(format: "closed = false"))
    var projects: FetchedResults<Project>

    static let tag: String? = "Home"
    let items: FetchRequest<Item>
    let rows = [GridItem(.fixed(100))]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: rows) {
                            ForEach(projects, content: ProjectSummaryView.init)
                        }
                        .padding(.horizontal)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.top)

                    VStack(alignment: .leading) {
                        ItemListView(title: "Up next", items: items.wrappedValue.prefix(4))
                        ItemListView(title: "Due later", items: items.wrappedValue.dropFirst(4))
                    }.padding(.horizontal)
                }
            }
            .background(Color.systemGroupedBackground.ignoresSafeArea())
            .navigationTitle("Home")
            .toolbar {

                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Add Data") {
                       dataController.deleteAll()
                       try? dataController.createSampleData()
                   }
                }
            }
        }
    }

    init() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let itemCompletedPredicate = NSPredicate(format: "completed = false")
        let projectClosedPredicate = NSPredicate(format: "project.closed = false")
        let compoundPredicate = NSCompoundPredicate(type: .and,
                                                    subpredicates: [itemCompletedPredicate, projectClosedPredicate])
        request.predicate = compoundPredicate

        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Item.dueDate, ascending: true),
            NSSortDescriptor(keyPath: \Item.priority, ascending: true)
        ]

        request.fetchLimit = 10
        items = FetchRequest(fetchRequest: request)
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

 /* Button("Add Data") {
    dataController.deleteAll()
    try? dataController.createSampleData()
} */
