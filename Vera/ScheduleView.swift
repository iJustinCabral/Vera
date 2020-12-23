//
//  ScheduleView.swift
//  Vera
//
//  Created by Justin Cabral on 12/21/20.
//

// swiftlint:disable trailing_whitespace
// swiftlint:disable multiple_closures_with_trailing_closure

import SwiftUI

struct ScheduleView: View {
        
    @State private var isShowingDayView = true
    @FetchRequest(entity: Project.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Project.creationDate, ascending: true)],
                  predicate: NSPredicate(format: "closed = false"))
    var projects: FetchedResults<Project>
    
    static let tag: String? = "Schedule"

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 240, maximum: 340))]) {
                    ForEach(projects, content: row)
                }
                .padding()
                .fixedSize(horizontal: false, vertical: true)
            }
            .background(Color.systemGroupedBackground.ignoresSafeArea(.all))
            .navigationTitle(Date().dayOfWeek() ?? "Schedule")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isShowingDayView.toggle() }) {
                        Text(isShowingDayView ? "Week" : "Day")
                    }
                }
            }
        }
    }
    
    func row(for project: Project) -> some View {
        RoundedRectangle(cornerRadius: 12, style: .continuous)
            .fill(Color.secondaryGroupedBackground)
            .frame(height: 100)
            .shadow(radius: 4)
            .overlay(
                Image(systemName: "bell")
                    .padding([.top, .trailing], 10)
                    .foregroundColor(Color(project.projectColor)), alignment: .topTrailing
            )
            .overlay(
                VStack {
                    Text(project.projectTitle)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .padding(.bottom)
                    
                    HStack {
                        VStack {
                            Text(Date().timeForDate(date: project.projectStartDate))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        
                        Text("-")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        VStack {
                            Text(Date().timeForDate(date: project.projectFinishDate))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 10)
                    .background(Color(project.projectColor))
                    .cornerRadius(12)
                    
                }, alignment: .center
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(project.projectColor))
                    .frame(width: 40, height: 100)
                    .overlay(
                        Rectangle()
                            .fill(Color(project.projectColor))
                            .frame(width: 20, height: 100), alignment: .trailing
                    ), alignment: .leading
                )

    }
    
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
