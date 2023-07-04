//
//  ChessPiece.swift
//  Chess
//
//  Created by Raymond Vleeshouwer on 01/07/23.
//

import Foundation
import SwiftUI

struct ChessPiece: Identifiable, View, Equatable {
    static func == (lhs: ChessPiece, rhs: ChessPiece) -> Bool {
        lhs.id == rhs.id
    }

    let id: UUID = UUID()
    var piece: Piece
    var index: Int

    var body: some View {
        pieceToImage(piece)
    }
}
