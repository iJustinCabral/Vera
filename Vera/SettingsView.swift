//
//  SettingsView.swift
//  Vera
//
//  Created by Justin Cabral on 12/20/20.
//

// swiftlint:disable trailing_whitespace

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isCloudSyncing = true
    
    static let tag: String? = "Settings"

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("")) {
                    VStack {
                        // swiftlint:disable:next line_length
                        Text("Upgrading to Vera Pro unlocks useful features and helps support the future development of this application.")
                            .padding([.top, .bottom], 20)
                        HStack(spacing: 20) {
                            upgradeButton(title: "Monthly", price: "$0.99", action: { })
                            upgradeButton(title: "Yearly", price: "$4.99", action: { })
                            upgradeButton(title: "Once", price: "$9.99", action: { })
                        }
                        .padding(.bottom)
                    }.padding(.horizontal, 10)
                    
                    VStack {
                        NavigationLink(destination: FeaturesView()) {
                            HStack {
                                Image("icon")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .cornerRadius(4)
                                    .shadow(radius: 4)
                                Text("Vera Pro Features")
                            }
                        }
                    }
                }
                
                Section(header: Text("iCloud")) {
                    HStack {
                        Toggle("iCloud Sync", isOn: $isCloudSyncing.onChange {
                            // Do something here when toggle is switched on or off
                        })
                    }
                   
                    Button("Sync Data") {
                        // Perform iCloud Sync here
                    }.disabled(!isCloudSyncing)
                }
                
                Section(header: Text("More")) {
                    Button("Rate on App Store") {
                        // TODO: Show app review
                    }
                    
                    Button("Share App") {
                        // TODO: Show Share sheet
                    }
                    
                    Button("Restore Purchases") {
                        // TODO: Restore In App Purchase
                    }
                }
                
                Section(header: Text("Developd by")) {
                    VStack(alignment: .center) {
                        Text("Justin Cabral")
                    }
                }
                
                Section(header: Text("")) {}
                
                Section(footer: Text("")) {
                    HStack {
                        Spacer()
                        Button("Reset App Data") {
                            
                        }.foregroundColor(.red)
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Settings")
            .background(Color.systemGroupedBackground)
        }
    }
    
    func upgradeButton(title: String, price: String, action: @escaping () -> Void) -> some View {
        HStack {
            Button(action: action) {
                VStack {
                    Text(title)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text(price)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color("AccentColor"))
                .cornerRadius(12)
                .shadow(radius: 4)

            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
