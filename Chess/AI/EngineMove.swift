//
//  EngineMove.swift
//  Chess
//
//  Created by Raymond Vleeshouwer on 06/07/23.
//

import Foundation

struct EngineMove {
    let moveType: MoveType
    let pieceType: Piece

    let startPosition: Int
    let endPosition: Int

    enum MoveType: UInt8, CaseIterable {
        case none = 0
        case taking = 1
    }
}
