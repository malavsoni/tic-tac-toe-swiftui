//
//  TicTacToeViewModelTests.swift
//  Tic Tac ToeTests
//
//  Created by Malav Soni on 20/01/22.
//

import XCTest
@testable import Tic_Tac_Toe


class TicTacToeViewModelTests: XCTestCase {
    
    let playersVsComputer:[AppPlayer] = [
        AppPlayer(kind: .player(name: "User"), icon: .mark),
        AppPlayer(kind: .computer, icon: .cross)
    ]
    
    let playersVsPlayer:[AppPlayer] = [
        AppPlayer(kind: .player(name: "User B"), icon: .cross),
        AppPlayer(kind: .player(name: "User A"), icon: .mark)
    ]

    func test_boxStatusSaved_and_computer_makeMove_onTapOfBox() throws {
        // Given
        let viewModel = BoardViewModel(gamePlayers: self.playersVsComputer, controller: MockTicTacToeController())
        
        // When
        viewModel.handleOnTap(atIndex: 0)
        
        // Then
        let numberOfCross = viewModel.boxes.compactMap{ $0 }.filter { $0 == .cross }.count
        let numberOfMark = viewModel.boxes.compactMap{ $0 }.filter { $0 == .mark }.count
        XCTAssertTrue(numberOfCross == 1, "Only one cross should be occupied")
        XCTAssertTrue(numberOfMark == 1, "Only one mark should be occupied")
    }
    
    func test_boxStatusSaved_onTapOfIndex() throws {
        // Given
        let viewModel = BoardViewModel(gamePlayers: self.playersVsPlayer, controller: MockTicTacToeController())
        
        // When
        viewModel.handleOnTap(atIndex: 0)
        
        // Then
        let numberOfCross = viewModel.boxes.compactMap{ $0 }.filter { $0 == .cross }.count
        let numberOfMark = viewModel.boxes.compactMap{ $0 }.filter { $0 == .mark }.count
        XCTAssertTrue(numberOfCross == 1, "Only one cross should be occupied")
        XCTAssertTrue(numberOfMark == 0, "Only one mark should be occupied")
    }
    
    func test_playerConsiderWin_if_logic_return_true() throws {
        // Given
        let viewModel = BoardViewModel(
            gamePlayers: self.playersVsPlayer,
            controller: MockTicTacToeController(
                wonPlayer: .cross,
                isDraw: false,
                nextAIMove: 3
            )
        )
        
        // When
        viewModel.handleOnTap(atIndex: 0)
        
        // Then
        XCTAssertTrue(viewModel.winner != nil, "Winner should be present")
        XCTAssertTrue(viewModel.winner == self.playersVsPlayer.first, "Winner should first player")
        XCTAssertTrue(viewModel.gamePlayers.first!.score == 1, "Score of first player should be 1")
    }
}
