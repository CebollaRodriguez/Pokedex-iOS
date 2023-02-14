//
//  DropDown.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 11/02/23.
//

import SwiftUI

struct DropDown: View {
    // Drop Down Properties
    @Binding var content: [Pokedexes]
    @Binding var selection: Pokedexes
    @Binding var expandView: Bool
    @Binding var wasChanged: Bool
    var activeTint: Color
    var inActiveTint: Color
    
    // View Properties
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(alignment: .leading, spacing: 0) {
                RowView(selection, size)
                if expandView {
                    ForEach(content.filter{
                        $0.name != selection.name
                    }, id: \.name) { pokedex in
                        RowView(pokedex, size)
                    }
                }
                
            }
            .background {
                Rectangle()
                    .fill(inActiveTint)
            }
            // Refresh View with the selection. Disabled for Non-Dynamic View
            //.offset(y: (CGFloat(content.firstIndex(of: selection) ?? 0) * -55))
            
        }
        .frame(height: 55)
        .overlay(alignment: .trailing) {
            Image(systemName: "chevron.up.chevron.down")
                .padding(.trailing, 10)
        }
        .mask(alignment: .top) {
            Rectangle()
                .frame(height: expandView ? CGFloat(content.count) * 55 : 55)
                // Refresh Mask with the selection when is expanded. Disabled for Non-Dynamic View
                //.offset(y: expandView ? (CGFloat(content.firstIndex(of: selection) ?? 0) * -55) : 0)
                
        }
    }
    
    @ViewBuilder
    func RowView(_ pokedex: Pokedexes, _ size: CGSize) -> some View {
        Text(pokedex.name)
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.horizontal)
            .frame(width: size.width, height: size.height, alignment: .leading)
            .background{
                if selection.name == pokedex.name {
                    Rectangle()
                        .fill(activeTint)
                        .transition(.identity)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                    if expandView {
                        expandView = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            if selection.name != pokedex.name {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    wasChanged.toggle()
                                }
                            }
                            selection = pokedex
                            
                        }
                        
                    } else {
                        if selection.name == pokedex.name {
                            expandView = true
                        }
                    }
                }
            }
    }
}
