//
//  ItemListView.swift
//  Vera
//
//  Created by Justin Cabral on 12/21/20.
//

import SwiftUI

struct ItemListView: View {

    let title: LocalizedStringKey
    let items: FetchedResults<Item>.SubSequence

    var body: some View {
        if items.isEmpty {
            EmptyView()
        } else {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.top)

            ForEach(items, content: itemRow)

        }
    }

    // Extract a view to a function return value with the correct parameter in order to replace it as content in ForEach
    private func itemRow(for item: Item) -> some View {
        NavigationLink(destination: EditItemView(item: item)) {
            HStack(spacing: 20) {
                Circle()
                    .fill(Color(item.project?.projectColor ?? "Light Blue"))
                    .frame(width: 22, height: 22)

                VStack(alignment: .leading) {
                    Text(item.itemTitle)
                        .font(.title2)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if item.itemDetail.isEmpty == false {
                        Text(item.itemDetail)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding()
        .background(Color.secondaryGroupedBackground)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5)
    }
}
/* struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
} */
