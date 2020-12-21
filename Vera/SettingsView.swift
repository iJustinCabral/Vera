//
//  SettingsView.swift
//  Vera
//
//  Created by Justin Cabral on 12/20/20.
//

// swiftlint:disable multiple_closures_with_trailing_closure
// swiftlint:disable trailing_whitespace

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var closeButton: some View {
        Button(action: { presentationMode.wrappedValue.dismiss() }) {
            Text("Close")
        }
    }
    
    var body: some View {
        NavigationView {
            Text("Settings View")
                .navigationBarTitle("Settings", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        closeButton
                    }
                }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
