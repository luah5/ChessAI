//
//  MoveIsLegal.swift
//  Chess
//
//  Created by Raymond Vleeshouwer on 02/07/23.
//

import Foundation

class LegalMove {
    private func meetsFlags(_ currentSquare: Int, _ newSquare: Int, board: Board, _ offset: MoveOffset) -> Bool {
        let currentSquarePlayer: Player = player(board.Squares[currentSquare].piece())
        let newSquarePlayer: Player = player(board.Squares[newSquare].piece())
        
        switch offset.flags {
        case .taking: return currentSquarePlayer != newSquarePlayer && board.Squares[newSquare].piece() != .None
        case .takingOptional: return true
        default: return true
        }
    }

    private func offsetIsLegal(
        _ currentSquare: Int,
        _ newSquare: Int,
        _ moveOffsets: MoveOffsets
    ) -> Bool {
        let squares: [Int] = board.Squares
        let currentSquarePiece: Piece = squares[currentSquare].piece()
        let newSquarePiece: Piece = squares[newSquare].piece()

        let currentSquarePiecePlayer: Player = player(currentSquarePiece)
        let newSquarePiecePlayer: Player = player(newSquarePiece)

        for offset in moveOffsets.offsets {
            if
                currentSquare + offset.offset == newSquare &&
                newSquarePiecePlayer != currentSquarePiecePlayer &&
                meetsFlags(currentSquare, newSquare, board: board, offset)
            {
                /*
                if moveOffsets.canJumpOverPieces {

                }
                */
                return true
            }
        }

        return false
    }

    private let whitePawnOffsets: MoveOffsets = .init([.init(-8, .none), .init(-16, .first), .init(-7, .taking), .init(-6, .taking)])
    private let blackPawnOffsets: MoveOffsets = .init([.init(8, .none), .init(16, .first), .init(7, .taking), .init(6, .taking)])

    var isLegal: Bool
    var board: Board

    init(board: Board, currentSquare: ChessPiece, newSquare: Int) {
        let currentIndex: Int = currentSquare.index
        self.board = board
        self.isLegal = false

        if
            currentSquare.index != newSquare &&
            currentSquare.piece != .None &&
            board.playerToPlay == player(currentSquare.piece)
        {
            switch currentSquare.piece {
            case .WhitePawn: isLegal = offsetIsLegal(currentIndex, newSquare, whitePawnOffsets)
            case .BlackPawn: isLegal = offsetIsLegal(currentIndex, newSquare, blackPawnOffsets)
            default: isLegal = false
            }
        }
    }
}
