//
//  Piece.swift
//  Chess
//
//  Created by Raymond Vleeshouwer on 01/07/23.
//

import Foundation
import SwiftUI

func fenToPiece(fen: String) -> Piece {
    switch fen {
    case "K": return Piece.WhiteKing
    case "P": return Piece.WhitePawn
    case "N": return Piece.WhiteKnight
    case "B": return Piece.WhiteBishop
    case "R": return Piece.WhiteRook
    case "Q": return Piece.WhiteQueen

    case "k": return Piece.BlackKing
    case "p": return Piece.BlackPawn
    case "n": return Piece.BlackKnight
    case "b": return Piece.BlackBishop
    case "r": return Piece.BlackRook
    case "q": return Piece.BlackQueen

    default: return Piece.None
    }
}

func pieceToImage(_ piece: Piece) -> Image {
    switch piece {
    case .None: return Image("Empty")

    case .WhiteKing: return Image("WhiteKing")
    case .WhitePawn: return Image("WhitePawn")
    case .WhiteKnight: return Image("WhiteKnight")
    case .WhiteBishop: return Image("WhiteBishop")
    case .WhiteRook: return Image("WhiteRook")
    case .WhiteQueen: return Image("WhiteQueen")

    case .BlackKing: return Image("BlackKing")
    case .BlackPawn: return Image("BlackPawn")
    case .BlackKnight: return Image("BlackKnight")
    case .BlackBishop: return Image("BlackBishop")
    case .BlackRook: return Image("BlackRook")
    case .BlackQueen: return Image("BlackQueen")
    }
}

enum Piece: Int, CaseIterable {
    case None = 0

    case WhiteKing = 1
    case WhitePawn = 2
    case WhiteKnight = 3
    case WhiteBishop = 4
    case WhiteRook = 5
    case WhiteQueen = 6

    case BlackKing = 7
    case BlackPawn = 8
    case BlackKnight = 9
    case BlackBishop = 10
    case BlackRook = 11
    case BlackQueen = 12
}

enum GenericPiece: Int, CaseIterable {
    case None = 0

    case King = 1
    case Pawn = 2
    case Knight = 3
    case Bishop = 4
    case Rook = 5
    case Queen = 6
}
