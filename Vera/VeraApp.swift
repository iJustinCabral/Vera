//
//  VeraApp.swift
//  Vera
//
//  Created by Justin Cabral on 12/18/20.
//

import SwiftUI

@main
struct VeraApp: App {

    @StateObject var dataController: DataController

    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: save) // swiftlint:disable:this line_length
        }
    }

    func save(_ note: Notification) {
        dataController.save()
    }
}
