//
//  ContentView.swift
//  Vera
//
//  Created by Justin Cabral on 12/18/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            ProjectsView(showClosedProjects: false)
                .tabItem {
                    Image(systemName: "pencil.slash")
                    Text("Classes")
                }
            
            ProjectsView(showClosedProjects: true)
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
