//
//  DismissView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 29/12/22.
//

import SwiftUI

struct DismissView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            Spacer()
            Button("Close") {
                dismiss()
            }
            .tint(.secondary)
            .padding(.trailing, 12)
        }
    }
}

struct DismissView_Previews: PreviewProvider {
    static var previews: some View {
        DismissView()
    }
}
