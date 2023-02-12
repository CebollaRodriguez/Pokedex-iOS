//
//  DropDown.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 11/02/23.
//

import SwiftUI

struct DropDown: View {
    // Drop Down Properties
    @Binding var content: [String]
    @Binding var selection: String
    var activeTint: Color
    var inActiveTint: Color
    
    // View Properties
    @State private var expandView: Bool = false
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(alignment: .leading, spacing: 0) {
                ForEach(content.filter{$0 != selection}, id: \.self) { title in
                    RowView(title, size)
                }
            }
            .background {
                Rectangle()
                    .fill(inActiveTint)
            }
            // Refresh View with the selection
            .offset(y: (CGFloat(content.firstIndex(of: selection) ?? 0) * -55))
        }
        .frame(height: 55)
        .overlay(alignment: .trailing) {
            Image(systemName: "chevron.up.chevron.down")
                .padding(.trailing, 10)
        }
        .mask(alignment: .top) {
            Rectangle()
                .frame(height: expandView ? CGFloat(content.count) * 55 : 55)
                // Refresh Mask with the selection when is expanded
                .offset(y: expandView ? (CGFloat(content.firstIndex(of: selection) ?? 0) * -55) : 0)

        }
    }
    
    @ViewBuilder
    func RowView(_ title: String, _ size: CGSize) -> some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.horizontal)
            .frame(width: size.width, height: size.height, alignment: .leading)
            .background{
                if selection == title {
                    Rectangle()
                        .fill(activeTint)
                        .transition(.identity)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                    if expandView {
                        selection = title
                        expandView = false
                    } else {
                        if selection == title {
                            expandView = true
                        }
                    }
                }
            }
    }
}
