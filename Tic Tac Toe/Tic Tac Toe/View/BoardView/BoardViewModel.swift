//
//  BoardViewModel.swift
//  Tic Tac Toe
//
//  Created by Malav Soni on 20/01/22.
//

import Foundation
import SwiftUI
 
final class BoardViewModel:ObservableObject {
    private(set) var gamePlayers:[AppPlayer]
    private(set) var isGameActive:Bool = true
    
    @Published private(set) var boxes:[BoxState?] = Array.init(repeating: nil, count: 9)
    @Published private(set) var messageToDisplay:String = ""
    @Published private(set) var drawCount:Int = 0
    @Published private(set) var currentPlayer:AppPlayer {
        didSet {
            self.messageToDisplay = self.currentPlayer.kind.name
        }
    }
    @Published private(set) var winner:AppPlayer? {
        didSet {
            if let winner = winner {
                isGameActive = false
                self.messageToDisplay = "\(winner.kind.name) has won"
            }
        }
    }
    
    private let gameController:TicTacToe
    private var boxStatesAsInt:[Int?] {
        self.boxes.map { $0?.rawValue }
    }
    
    init(
        gamePlayers:[AppPlayer],
        controller:TicTacToe = TicTacToeController()
    ) {
        assert(gamePlayers.count == 2, "Inappropriate Players")
        self.gameController = controller
        self.gamePlayers = gamePlayers
        self.currentPlayer = gamePlayers[0]
        self.messageToDisplay = self.currentPlayer.kind.name
    }
    
    func handleOnReset() {
        self.boxes = Array.init(repeating: nil, count: 9)
        if let firstPlayer = self.gamePlayers.first {
            self.currentPlayer = firstPlayer
        }
        self.isGameActive = true
        self.winner = nil
    }
    
    func handleOnTap(atIndex index:Int) {
        // Add Move
        guard
            self.boxes[index] == nil &&
                self.isGameActive &&
                self.boxes.indices.contains(index)
        else {
            return
        }
        self.boxes[index] = self.currentPlayer.icon
        
        // Check for Win
        if self.gameController.checkForWinConditions(
            forMoves: self.boxStatesAsInt,
            forPlayer: self.currentPlayer.icon.rawValue
        ) {
            if let winnerIndex = self.gamePlayers.firstIndex(of: self.currentPlayer) {
                self.winner = self.gamePlayers[winnerIndex]
                self.gamePlayers[winnerIndex].incrementScore()
            }
            return
        }
        
        // Check for draw
        
        if self.gameController.isMatchDraw(for: self.boxStatesAsInt) {
            self.messageToDisplay = "The match is draw"
            drawCount += 1
            return
        }
        
        // Change the current player
        self.toggleTurn()
        
        // If current player is computer then make the next move
        if self.currentPlayer.kind == .computer {
            // Find the index
            // Call the same method again with that index
            self.handleOnTap(atIndex: self.findNextComputerMoveIndex())
        }
    }
}

private extension BoardViewModel {
    func toggleTurn() {
        guard let playerOne = self.gamePlayers.first, let playerTwo = self.gamePlayers.last else {
            return
        }
        self.currentPlayer = self.currentPlayer == playerOne ? playerTwo : playerOne
    }
    
    func findNextComputerMoveIndex() -> Int {
        guard let computerPlayer = self.gamePlayers.first (where: { player in
            player.kind == .computer
        }) else {
            assertionFailure("Computer Player must be present in active players list to calculate next AI move")
            return -1
        }
        
        return self.gameController.calculateNextMove(
            from: self.boxStatesAsInt,
            computerMoveIndicator: computerPlayer.icon.rawValue,
            opponentMoveIndicate: computerPlayer.icon.opposite.rawValue
        )
    }
}
