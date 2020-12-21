//
//  ProjectHeaderView.swift
//  Vera
//
//  Created by Justin Cabral on 12/19/20.
//

import SwiftUI

struct ProjectHeaderView: View {
    
    @ObservedObject var project: Project
    
    var startDay: String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        return dateFormatterPrint.string(from: project.creationDate!)
    }
    
    var finishDay: String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        return dateFormatterPrint.string(from: project.finishDate ?? Date().addingTimeInterval(86000))
    }
    
    var itemCount: Int {
        let originalItems = project.items?.allObjects as? [Item] ?? []
        guard originalItems.isEmpty == false else { return 0 }
        
        return originalItems.count
    }
    
    var itemCompleteCount: Int {
        let originalItems = project.items?.allObjects as? [Item] ?? []
        guard originalItems.isEmpty == false else { return 0 }
        let completedItems = originalItems.filter(\.completed)
        
        return completedItems.count
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(project.projectTitle)
                    Spacer()
                    NavigationLink(destination: EditProjectView(project: project)) {
                        Text("Edit")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(project.projectColor))
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .imageScale(.large)
                            .frame(width:20, height: 20)
                            .foregroundColor(Color(project.projectColor))
                    }
                }
                
                ProgressView(value: project.completionAmount)
                    .accentColor(Color(project.projectColor))
                
                HStack {
                    Text(itemCompleteCount < 10 ? "0\(itemCompleteCount)" : "\(itemCompleteCount)")
                    
                    Spacer()
                    
                    Text(itemCount < 10 ? "0\(itemCount)" : "\(itemCount)")
                }
            }
            
            Spacer()
            
       
        }
        .padding(.bottom, 10)
    }
}

struct ProjectHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHeaderView(project: Project.example)
    }
}
