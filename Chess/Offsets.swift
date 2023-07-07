//
//  Offsets.swift
//  Chess
//
//  Created by Raymond Vleeshouwer on 04/07/23.
//

import Foundation

let whitePawnOffsets: MoveOffsets = .init(
    [
        .init(-8, .none, .vertical),
        .init(-16, .pawnFirst, .vertical),
        .init(-7, .taking, .none),
        .init(-9, .taking, .none)
    ]
)

let blackPawnOffsets: MoveOffsets = .init(
    [
        .init(8, .none, .vertical),
        .init(16, .pawnFirst, .vertical),
        .init(7, .taking, .none),
        .init(9, .taking, .none)
    ]
)

let rookOffsets: MoveOffsets = .init(
    [
        .init(1, .takingOptional, .horizontal),
        .init(2, .takingOptional, .horizontal),
        .init(3, .takingOptional, .horizontal),
        .init(4, .takingOptional, .horizontal),
        .init(5, .takingOptional, .horizontal),
        .init(6, .takingOptional, .horizontal),
        .init(7, .takingOptional, .horizontal),
        .init(8, .takingOptional, .horizontal),
        .init(-1, .takingOptional, .horizontal),
        .init(-2, .takingOptional, .horizontal),
        .init(-3, .takingOptional, .horizontal),
        .init(-4, .takingOptional, .horizontal),
        .init(-5, .takingOptional, .horizontal),
        .init(-6, .takingOptional, .horizontal),
        .init(-7, .takingOptional, .horizontal),
        .init(-8, .takingOptional, .horizontal),
        .init(8, .takingOptional, .vertical),
        .init(16, .takingOptional, .vertical),
        .init(24, .takingOptional, .vertical),
        .init(32, .takingOptional, .vertical),
        .init(40, .takingOptional, .vertical),
        .init(48, .takingOptional, .vertical),
        .init(56, .takingOptional, .vertical),
        .init(-8, .takingOptional, .vertical),
        .init(-16, .takingOptional, .vertical),
        .init(-24, .takingOptional, .vertical),
        .init(-32, .takingOptional, .vertical),
        .init(-40, .takingOptional, .vertical),
        .init(-48, .takingOptional, .vertical),
        .init(-56, .takingOptional, .vertical)
    ]
)

let knightOffsets: MoveOffsets = .init(
    [
        .init(17, .takingOptional, .none),
        .init(15, .takingOptional, .none),
        .init(10, .takingOptional, .none),
        .init(6, .takingOptional, .none),
        .init(-6, .takingOptional, .none), // might need to be changed
        .init(-10, .takingOptional, .none),
        .init(-15, .takingOptional, .none),
        .init(-17, .takingOptional, .none),
    ],
    true
)

let kingOffsets: MoveOffsets = .init(
    [
        .init(1, .takingOptional, .horizontal),
        .init(-1, .takingOptional, .horizontal),
        .init(6, .takingOptional, .none),
        .init(8, .takingOptional, .vertical),
        .init(9, .takingOptional, .none),
        .init(-6, .takingOptional, .none),
        .init(-8, .takingOptional, .vertical),
        .init(-9, .takingOptional, .none)
    ]
)


let bishopOffsets: MoveOffsets = .init(
    [
        .init(9, .takingOptional, .none),
        .init(18, .takingOptional, .none),
        .init(27, .takingOptional, .none),
        .init(36, .takingOptional, .none),
        .init(45, .takingOptional, .none),
        .init(54, .takingOptional, .none),
        .init(63, .takingOptional, .none),
        .init(-9, .takingOptional, .none),
        .init(-18, .takingOptional, .none),
        .init(-27, .takingOptional, .none),
        .init(-36, .takingOptional, .none),
        .init(-45, .takingOptional, .none),
        .init(-54, .takingOptional, .none),
        .init(-63, .takingOptional, .none),
        .init(7, .takingOptional, .none),
        .init(14, .takingOptional, .none),
        .init(21, .takingOptional, .none),
        .init(28, .takingOptional, .none),
        .init(35, .takingOptional, .none),
        .init(42, .takingOptional, .none),
        .init(49, .takingOptional, .none),
        .init(-7, .takingOptional, .none),
        .init(-14, .takingOptional, .none),
        .init(-21, .takingOptional, .none),
        .init(-28, .takingOptional, .none),
        .init(-35, .takingOptional, .none),
        .init(-42, .takingOptional, .none),
        .init(-49, .takingOptional, .none)
    ]
)

let queenOffsets: MoveOffsets = .init(
    [
        .init(1, .takingOptional, .horizontal),
        .init(2, .takingOptional, .horizontal),
        .init(3, .takingOptional, .horizontal),
        .init(4, .takingOptional, .horizontal),
        .init(5, .takingOptional, .horizontal),
        .init(6, .takingOptional, .horizontal),
        .init(7, .takingOptional, .horizontal),
        .init(8, .takingOptional, .horizontal),
        .init(-1, .takingOptional, .horizontal),
        .init(-2, .takingOptional, .horizontal),
        .init(-3, .takingOptional, .horizontal),
        .init(-4, .takingOptional, .horizontal),
        .init(-5, .takingOptional, .horizontal),
        .init(-6, .takingOptional, .horizontal),
        .init(-7, .takingOptional, .horizontal),
        .init(-8, .takingOptional, .horizontal),
        .init(8, .takingOptional, .vertical),
        .init(16, .takingOptional, .vertical),
        .init(24, .takingOptional, .vertical),
        .init(32, .takingOptional, .vertical),
        .init(40, .takingOptional, .vertical),
        .init(48, .takingOptional, .vertical),
        .init(56, .takingOptional, .vertical),
        .init(-8, .takingOptional, .vertical),
        .init(-16, .takingOptional, .vertical),
        .init(-24, .takingOptional, .vertical),
        .init(-32, .takingOptional, .vertical),
        .init(-40, .takingOptional, .vertical),
        .init(-48, .takingOptional, .vertical),
        .init(-56, .takingOptional, .vertical),
        .init(9, .takingOptional, .none),
        .init(18, .takingOptional, .none),
        .init(27, .takingOptional, .none),
        .init(36, .takingOptional, .none),
        .init(45, .takingOptional, .none),
        .init(54, .takingOptional, .none),
        .init(63, .takingOptional, .none),
        .init(-9, .takingOptional, .none),
        .init(-18, .takingOptional, .none),
        .init(-27, .takingOptional, .none),
        .init(-36, .takingOptional, .none),
        .init(-45, .takingOptional, .none),
        .init(-54, .takingOptional, .none),
        .init(-63, .takingOptional, .none),
        .init(7, .takingOptional, .none),
        .init(14, .takingOptional, .none),
        .init(21, .takingOptional, .none),
        .init(28, .takingOptional, .none),
        .init(35, .takingOptional, .none),
        .init(42, .takingOptional, .none),
        .init(49, .takingOptional, .none),
        .init(-7, .takingOptional, .none),
        .init(-14, .takingOptional, .none),
        .init(-21, .takingOptional, .none),
        .init(-28, .takingOptional, .none),
        .init(-35, .takingOptional, .none),
        .init(-42, .takingOptional, .none),
        .init(-49, .takingOptional, .none)
    ]
)
