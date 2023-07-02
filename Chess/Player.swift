//
//  Player.swift
//  Chess
//
//  Created by Raymond Vleeshouwer on 02/07/23.
//

import Foundation

func player(_ lastMovePiece: Piece) -> Player {
    if lastMovePiece.rawValue < 6 && lastMovePiece != .None {
        return .white
    } else if lastMovePiece != .None {
        return .black
    } else {
        return .none
    }
}

enum Player: String, CaseIterable {
    case none = "None"
    case white = "White"
    case black = "Black"
}
