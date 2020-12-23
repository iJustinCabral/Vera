//
//  FeaturesView.swift
//  Vera
//
//  Created by Justin Cabral on 12/22/20.
//

// swiftlint:disable trailing_whitespace

import SwiftUI

struct FeaturesView: View {
    
    var body: some View {
        Form {
            Section(header: Text("Vera Pro Features")) {
                HStack {
                    Spacer()
                    VStack {
                        Image("icon")
                            .cornerRadius(10)
                            .shadow(radius: 4)
                            .padding(.top)
                        Text("Vera Pro")
                            .font(.largeTitle)
                            .padding(.bottom)
                    }
                    Spacer()
                }
                
                row(withImage: "bell.fill", color: .blue, title: "Notifications")
                row(withImage: "deskclock.fill", color: .green, title: "Item Reminders")
                row(withImage: "square.split.1x2.fill", color: .purple, title: "Widget Support")
                row(withImage: "app.fill", color: .orange, title: "Custom Icons")
                row(withImage: "heart.fill", color: .red, title: "Developer Support")
                
            }
            
            Section(header: Text("Upgrade")) {
                HStack {
                    Text("Monthly")
                        .fontWeight(.semibold)
                    Spacer()
                    buyButton(title: "$0.99", action: { })
                }
                
                HStack {
                    Text("Yearly")
                        .fontWeight(.semibold)
                    Spacer()
                    buyButton(title: "$4.99", action: { })
                }
                
                HStack {
                    Text("One-time Purchase")
                        .fontWeight(.semibold)
                    Spacer()
                    buyButton(title: "$9.99", action: { })
                }
            }
        }
            .navigationTitle("Features")
    }
    
    private func row(withImage image: String, color: Color, title: String) -> some View {
        HStack {
            Image(systemName: image)
                .padding(8)
                .foregroundColor(.white)
                .background(color)
                .cornerRadius(4)
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            Spacer()
            Image(systemName: "checkmark")
                .foregroundColor(Color("AccentColor"))
        }
    }
    
    private func buyButton(title: String, action: @escaping () -> Void) -> some View {
        Button(title, action: action)
            .padding(8)
            .font(.body)
            .background(Color("AccentColor"))
            .foregroundColor(.white)
            .cornerRadius(12)
            .buttonStyle(PlainButtonStyle())
    }
}

struct FeaturesView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesView()
    }
}
