//
//  TurnIndicator.swift
//  Tic Tac Toe
//
//  Created by Malav Soni on 20/01/22.
//

import SwiftUI

struct TurnIndicator: View {
    let turn:BoxState
    var body: some View {
        HStack {
            Image(systemName: BoxState.mark.systemImage)
                .background(Circle().fill(self.turn == BoxState.mark ? BoxState.mark.color : Color.secondaryColor))
            
            Image(systemName: BoxState.cross.systemImage)
                .background(Circle().fill(self.turn == BoxState.cross ? BoxState.cross.color : Color.secondaryColor))
        }
        .font(.largeTitle)
        .foregroundColor(.white)
        .padding(.vertical)
        .accessibilityIdentifier("Reset_Turn_Indicator")
    }
}

struct TurnIndicator_Previews: PreviewProvider {
    static var previews: some View {
        TurnIndicator(turn: .cross)
            .previewLayout(.sizeThatFits)
        TurnIndicator(turn: .mark)
            .previewLayout(.sizeThatFits)
    }
}
