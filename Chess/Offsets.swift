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
        .init(-16, .first, .vertical),
        .init(-6, .taking, .none),
        .init(-7, .taking, .none)
    ]
)

let blackPawnOffsets: MoveOffsets = .init(
    [
        .init(8, .none, .vertical),
        .init(16, .first, .vertical),
        .init(6, .taking, .none),
        .init(7, .taking, .none)
    ]
)
