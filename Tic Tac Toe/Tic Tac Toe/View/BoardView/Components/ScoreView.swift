//
//  ScoreView.swift
//  Tic Tac Toe
//
//  Created by Malav Soni on 20/01/22.
//

import SwiftUI

struct ScoreView: View {
    
    let gamePlayers:[AppPlayer]
    let drawCount:Int
    
    var body: some View {
        HStack {
            ForEach(self.gamePlayers, id:\.self) { player in
                VStack(alignment:.center) {
                    Image(systemName: player.icon.systemImage)
                        .font(.system(size: 25))
                    Text("\(player.score) wins")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                }.foregroundColor(player.icon.color)
                    .frame(maxWidth: .infinity)
            }
            
            VStack(alignment:.center) {
                Image(systemName: "square.circle.fill")
                    .font(.system(size: 25))
                Text("\(self.drawCount) draws")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
            }.foregroundColor(Color.secondaryColor)
                .frame(maxWidth: .infinity)
        }
        .accessibilityIdentifier("Score_View_Indicator")
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(gamePlayers:
            [AppPlayer(kind: .computer, icon: .cross),
             AppPlayer(kind: .player(name: "Malav"), icon: .mark)],
            drawCount: 5
        ).previewLayout(.sizeThatFits)
    }
}
