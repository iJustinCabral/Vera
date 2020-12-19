//
//  ContentView.swift
//  Vera
//
//  Created by Justin Cabral on 12/18/20.
//

import SwiftUI

struct ContentView: View {
    
    //"selectedView" sets the name of the UserDefaults key
    @SceneStorage("selectedView") var selectedView: String?
    
    var body: some View {
        
        TabView(selection: $selectedView) {
            HomeView()
                .tag(HomeView.tag)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            ProjectsView(showClosedProjects: false)
                .tag(ProjectsView.classesTag)
                .tabItem {
                    Image(systemName: "pencil.slash")
                    Text("Classes")
                }
            
            ProjectsView(showClosedProjects: true)
                .tag(ProjectsView.finishedTag)
                .tabItem {
                    Image(systemName: "archivebox")
                    Text("Finished")
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
