//
//  Player.swift
//  Tic Tac Toe
//
//  Created by Malav Soni on 20/01/22.
//

import Foundation

struct AppPlayer: Equatable, Hashable {
    
    enum Kind: Comparable {
        case player(name:String)
        case computer
        
        var name:String {
            switch self {
            case .player(let name):
                return name.capitalized
            case .computer:
                return "Computer"
            }
        }
        
        static func < (lhs: Kind, rhs: Kind) -> Bool {
            lhs.name == rhs.name
        }
    }
    
    let kind:Kind
    var icon:BoxState
    var score:Int = 0
    func copyWith(kind:Kind? = nil, icon:BoxState? = nil, score:Int?) -> AppPlayer {
        return AppPlayer(kind: kind ?? self.kind, icon: icon ?? self.icon, score: score ?? self.score)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(icon)
    }
    
    mutating func incrementScore() {
        self.score += 1
    }
}


