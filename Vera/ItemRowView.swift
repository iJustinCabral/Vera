//
//  ItemRowView.swift
//  Vera
//
//  Created by Justin Cabral on 12/19/20.
//

import SwiftUI

struct ItemRowView: View {

    @ObservedObject var project: Project
    @ObservedObject var item: Item

    var icon: some View {
        if item.completed {
            return Image(systemName: "checkmark.circle.fill")
                .foregroundColor(Color(project.projectColor))
        } else if item.priority == 1 {
            return Image(systemName: "circlebadge.fill")
                .foregroundColor(Color(project.projectColor))
        } else if item.priority == 2 {
            return Image(systemName: "diamond.fill")
                .foregroundColor(Color(project.projectColor))
        } else if item.priority == 3 {
            return Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(Color(project.projectColor))
        } else {
            return Image(systemName: "checkmark.circle")
                .foregroundColor(.clear)
        }
    }

    var label: Text {
        if item.completed {
            return Text("\(item.itemTitle), completed.")
        } else if item.priority == 3 {
            return Text("\(item.itemTitle), high priority.")
        } else {
            return Text(item.itemTitle)
        }
    }

    var body: some View {
        NavigationLink(destination: EditItemView(item: item)) {
            Label {
                if item.completed {
                    Text(item.itemTitle).strikethrough()
                } else {
                    Text(item.itemTitle)
                }
            }
            icon: {
                icon
            }
        }
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(project: Project.example, item: Item.example)
    }
}
