//
//  NewProjectView.swift
//  Vera
//
//  Created by Justin Cabral on 12/20/20.
//

import SwiftUI

struct NewProjectView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12.0, style: .continuous)
            .background(Color.systemGroupedBackground)
            .shadow(color: Color.black.opacity(0.2), radius: 4)
            .frame(width: 360, height: 520)
    }
}

struct NewProjectView_Previews: PreviewProvider {
    static var previews: some View {
        NewProjectView()
    }
}
