//
//  ContentView.swift
//  Vera
//
//  Created by Justin Cabral on 12/18/20.
//

import SwiftUI

struct ContentView: View {

    // "selectedView" sets the name of the UserDefaults key
    @SceneStorage("selectedView") var selectedView: String?

    var body: some View {

        TabView(selection: $selectedView) {
            HomeView()
                .tag(HomeView.tag)
                .tabItem {
                    Image(systemName: "pencil.slash")
                    Text("Home")
                }

            ProjectView(showClosedProjects: false)
                .tag(ProjectView.classesTag)
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("Classes")
                }

            ProjectView(showClosedProjects: true)
                .tag(ProjectView.archiveTag)
                .tabItem {
                    Image(systemName: "archivebox")
                    Text("Archive")
                }

            AwardsView()
                .tag(AwardsView.tag)
                .tabItem {
                    Image(systemName: "rosette")
                    Text("Awards")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {

    static var dataController = DataController.preview

    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }

}
