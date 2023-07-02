//
//  Int+toPiece.swift
//  Chess
//
//  Created by Raymond Vleeshouwer on 01/07/23.
//

import Foundation

extension Int {
    func piece() -> Piece {
        for piece in Piece.allCases {
            if piece.rawValue == self {
                return piece
            }
        }

        return Piece.None
    }
}
