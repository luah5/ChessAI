//
//  Move.swift
//  Chess
//
//  Created by Raymond Vleeshouwer on 06/07/23.
//

import Foundation

struct Move: Equatable {
    let startPosition: Int
    let endPosition: Int
    let type: Piece
}
