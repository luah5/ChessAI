//
//  MoveOffset.swift
//  Chess
//
//  Created by Raymond Vleeshouwer on 03/07/23.
//

import Foundation

struct MoveOffset: Identifiable, Equatable {
    internal let id: UUID = UUID()
    let offset: Int
    let flags: Flags
    let direction: Direction

    init(_ offset: Int, _ flags: Flags, _ direction: Direction) {
        self.offset = offset
        self.flags = flags
        self.direction = direction
    }

    enum Flags: CaseIterable {
        case none

        case taking
        case takingOptional
        case pawnFirst
        case enPassant
        case castling
    }

    enum Direction: CaseIterable {
        case none

        case vertical
        case horizontal
    }
}

struct MoveOffsets {
    let offsets: [MoveOffset]
    let canJumpOverPieces: Bool

    init(_ offsets: [MoveOffset], _ canJumpOverPieces: Bool = false) {
        self.offsets = offsets
        self.canJumpOverPieces = canJumpOverPieces
    }
}
