//
//  BoardView.swift
//  Tic Tac Toe
//
//  Created by Malav Soni on 20/01/22.
//

import SwiftUI

struct BoardView: View {
    
    @StateObject private var viewModel:BoardViewModel
    
    init(
        gamePlayers:[AppPlayer] = [
            AppPlayer(kind: .player(name: "Player 1"), icon: .mark),
            AppPlayer(kind: .computer, icon: .cross)
        ],
        controller:TicTacToe = TicTacToeController()
    ) {
        self._viewModel = StateObject(wrappedValue: BoardViewModel(gamePlayers: gamePlayers, controller: controller))
    }
    
    var body: some View {
        VStack {
            GradientTextView {
                Text("Tic Tac Toe".uppercased())
                    .font(.system(size: 45, weight: .bold, design: .rounded))
            }
            
            ScoreView(
                gamePlayers: self.viewModel.gamePlayers,
                drawCount: self.viewModel.drawCount
            ).padding(.vertical)
            
            BoardGridView(
                boxes: self.viewModel.boxes,
                onTap: self.viewModel.handleOnTap(atIndex:)
            )
            
            TurnIndicator(turn: self.viewModel.currentPlayer.icon)
            
            ActionMenu(message: self.viewModel.messageToDisplay) {
                
            } onResetGameTap: {
                self.viewModel.handleOnReset()
            }
        }
        .padding()
        .animation(.default, value: self.viewModel.boxes)
        .animation(.default, value: self.viewModel.winner)
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.1).ignoresSafeArea())
        .accessibilityIdentifier("Board_View_Indicator")
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}
