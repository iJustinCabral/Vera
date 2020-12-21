//
//  EditProjectView.swift
//  Vera
//
//  Created by Justin Cabral on 12/19/20.
//

// swiftlint:disable trailing_whitespace

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
    let hugeNumber: Double = 900000000000000000

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
                DatePicker(selection: $startDate.onChange(update),
                           in: ...Date().addingTimeInterval(TimeInterval(hugeNumber)),
                           displayedComponents: .date) {
                    Text("Start Date")
                }

                DatePicker(selection: $finishDate.onChange(update),
                           in: ...Date().addingTimeInterval(TimeInterval(hugeNumber)),
                           displayedComponents: .date) {
                    Text("Finish Date")
                }

            }

            Section(header: Text("Class color")) {
                LazyVGrid(columns: colorColumns) {
                    ForEach(Project.colors, id: \.self, content: colorButton)
                }
                .padding(.vertical)
            }
            
            // swiftlint:disable:next line_length
            Section(footer: Text("Archiving a class moves it from Classes to Archive tab; deleting it removes the class entirely.")) {
                Button(project.closed ? "Unarchive class" : "Archive class") {
                    project.closed.toggle()
                    update()
                }

                Button("Delete class") {
                    showingDeleteConfirm.toggle()
                }
                .accentColor(.red)
            }
        }
        .navigationTitle("Edit Class")
        .onDisappear(perform: dataController.save)
        .alert(isPresented: $showingDeleteConfirm) {
            Alert(title: Text("Delete Class?"),
                  message: Text("Are you sure you want to delete this class? It will remove all the items it contains."), // swiftlint:disable:this line_length
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

    func colorButton(for item: String) -> some View {
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
        .accessibilityElement(children: .ignore)
        .accessibilityAddTraits(
            item == color
                ? [.isButton, .isSelected]
                : .isButton
        )
        .accessibilityLabel(LocalizedStringKey(item))
    }
}

struct EditProjectView_Previews: PreviewProvider {
    static var previews: some View {
        EditProjectView(project: Project.example)
    }
}
