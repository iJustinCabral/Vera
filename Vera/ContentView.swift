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
            ScheduleView()
                .tag(ScheduleView.tag)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Schedule")
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

            SettingsView()
                .tag(SettingsView.tag)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
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
