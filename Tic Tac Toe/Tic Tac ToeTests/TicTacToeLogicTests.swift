//
//  TicTacToeLogicTests.swift
//  Tic Tac ToeTests
//
//  Created by Malav Soni on 20/01/22.
//

import XCTest
@testable import Tic_Tac_Toe

class TicTacToeLogicTests: XCTestCase {

    func test_positive_scenario_for_win_condition() throws {
        // Given
        let controller = TicTacToeController()
        let boxes:[Int?] = [
            0  , nil , 1,
           nil ,  0  , 1,
           nil , nil , 0
        ]
        
        // When / Then
        XCTAssertTrue(controller.checkForWinConditions(forMoves: boxes, forPlayer: 0), "Player 0 should win")
        XCTAssertFalse(controller.checkForWinConditions(forMoves: boxes, forPlayer: 1), "Player 1 should lose")
    }
    
    func test_negative_scenario_for_win_condition() throws {
        // Given
        let controller = TicTacToeController()
        let boxes:[Int?] = [
             0  , nil , 1,
            nil ,  0  , 1,
            nil , nil , nil
        ]
        
        // When / Then
        XCTAssertFalse(controller.checkForWinConditions(forMoves: boxes, forPlayer: 0), "Player 0 should lose")
        XCTAssertFalse(controller.checkForWinConditions(forMoves: boxes, forPlayer: 1), "Player 1 should lose")
    }
    
    func test_positive_scenario_for_draw_condition() throws {
        // Given
        let controller = TicTacToeController()
        let boxes:[Int?] = [
             1  ,  0  , 1 ,
             0  ,  0  , 1 ,
             0  ,  1  , 0
        ]
        
        // When / Then
        XCTAssertTrue(controller.isMatchDraw(for: boxes), "Match is draw")
    }
    
    func test_negative_scenario_for_draw_condition() throws {
        // Given
        let controller = TicTacToeController()
        let boxes:[Int?] = [
             0  ,  nil , 1,
             0  ,  0  , nil,
             0  ,  1  , 0
        ]
        
        // When / Then
        XCTAssertFalse(controller.isMatchDraw(for: boxes), "Match isn't finished yet")
    }

}
