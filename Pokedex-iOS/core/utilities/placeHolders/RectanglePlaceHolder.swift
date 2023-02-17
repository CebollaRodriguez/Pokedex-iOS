//
//  RectanglePlaceHolder.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 16/02/23.
//

import SwiftUI

struct RectanglePlaceHolder: View {
    var width: CGFloat
    var height: CGFloat
    var radius: CGFloat = 5
    var body: some View {
        Rectangle()
            .foregroundColor(.secondary)
            .frame(width: width, height: height)
            .cornerRadius(radius)
        
    }
}

struct RectanglePlaceHolder_Previews: PreviewProvider {
    static var previews: some View {
        RectanglePlaceHolder(width: 10, height: 20)
    }
}
