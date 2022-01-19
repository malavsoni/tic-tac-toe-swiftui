//
//  GameLogicHelper.swift
//  Tic Tac Toe
//
//  Created by Malav Soni on 20/01/22.
//

import Foundation

protocol TicTacToe {
    typealias State = Int
    typealias Player = Int
    var winningSequences:Set<Set<Int>> { get }
    func checkForWinConditions(forMoves moves:[State?], forPlayer player:Player) -> Bool
    func isMatchDraw(for moves:[State?]) -> Bool
    func calculateNextMove(from moves:[State?], computerMoveIndicator:State, opponentMoveIndicate:State) -> Int
}

class TicTacToeController: TicTacToe {
    
    var winningSequences:Set<Set<Int>> {
        [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    }
    
    func checkForWinConditions(
        forMoves moves:[State?],
        forPlayer player:Player
    ) -> Bool {
        var indices:Set<State> = Set()
        for (index,value) in moves.enumerated() {
            if let value = value, value == player {
                indices.insert(index)
            }
        }
        for sequence in self.winningSequences where sequence.isSubset(of: indices) {
            return true
        }
        return false
    }
    
    func isMatchDraw(
        for moves:[State?]
    ) -> Bool {
        return moves.filter { $0 == nil }.count == 0
    }
    
    func calculateNextMove(
        from moves:[State?],
        computerMoveIndicator:State,
        opponentMoveIndicate:State
    ) -> Int {
        var computerPositions:Set<Int> = Set()
        var opponentPositions:Set<Int> = Set()
        var emptyPositions:Set<Int> = Set()
        
        for (index,value) in moves.enumerated() {
            if computerMoveIndicator == value {
                computerPositions.insert(index)
            } else if opponentMoveIndicate == value {
                opponentPositions.insert(index)
            } else {
                emptyPositions.insert(index)
            }
        }
        
        // Find positions where computer can win
        for sequence in self.winningSequences {
            let winPositions = sequence.subtracting(computerPositions)
            if winPositions.count == 1, let position = winPositions.first, moves[position] == nil {
                return position
            }
        }
        // Block the opponent / human
        for sequence in self.winningSequences {
            let winPositions = sequence.subtracting(opponentPositions)
            if winPositions.count == 1, let position = winPositions.first, moves[position] == nil {
                return position
            }
        }
        
        // Take center one if available
        if emptyPositions.contains(4) {
            return 4
        }
        
        return emptyPositions.randomElement() ?? -1
    }
}
