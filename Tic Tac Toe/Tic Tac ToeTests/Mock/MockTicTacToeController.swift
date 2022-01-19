//
//  MockTicTacToeController.swift
//  Tic Tac ToeTests
//
//  Created by Malav Soni on 20/01/22.
//

import Foundation
@testable import Tic_Tac_Toe

class MockTicTacToeController:TicTacToeController {
    
    let wonPlayer:BoxState?
    let isDraw:Bool?
    let nextMoveIndex:Int?
    
    init(
     wonPlayer:BoxState? = nil,
     isDraw:Bool? = nil,
     nextAIMove:Int? = nil
    ) {
        self.wonPlayer = wonPlayer
        self.isDraw = isDraw
        self.nextMoveIndex = nextAIMove
    }
    
    override func checkForWinConditions(forMoves moves:[State?], forPlayer player:Player) -> Bool {
        if let winner = wonPlayer {
            return player == winner.rawValue
        }
        return super.checkForWinConditions(forMoves: moves, forPlayer: player)
    }
    
    override func isMatchDraw(for moves:[State?]) -> Bool {
        if let isDraw = isDraw {
            return isDraw
        }
        return super.isMatchDraw(for: moves)
    }
    
    override func calculateNextMove(from moves:[State?], computerMoveIndicator:State, opponentMoveIndicate:State) -> Int {
        if let nextMoveIndex = nextMoveIndex {
            return nextMoveIndex
        }
        return super.calculateNextMove(
            from: moves,
            computerMoveIndicator: computerMoveIndicator,
            opponentMoveIndicate: opponentMoveIndicate
        )
    }
}
