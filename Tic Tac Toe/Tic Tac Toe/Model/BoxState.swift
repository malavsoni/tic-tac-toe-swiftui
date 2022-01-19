//
//  BoxState.swift
//  Tic Tac Toe
//
//  Created by Malav Soni on 20/01/22.
//

import Foundation
import SwiftUI

enum BoxState:Int, Equatable, Identifiable, Hashable{
    var id:String {
        return UUID().uuidString
    }
    case cross
    case mark
    
    var systemImage:String {
        switch self {
        case .cross:
            return "xmark.circle"
        case .mark:
            return "checkmark.circle"
        }
    }
    
    var color:Color {
        switch self {
        case .cross:
            return Color.mark
        case .mark:
            return Color.cross
        }
    }
    
    var opposite:BoxState {
        switch self { 
        case .cross:
            return .mark
        case .mark:
            return .cross
        }
    }
}
