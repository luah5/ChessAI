//
//  MoveIsLegal.swift
//  Chess
//
//  Created by Raymond Vleeshouwer on 02/07/23.
//

import Foundation

class Move {
    private func offsetIsLegal(
        _ currentSquare: Int,
        _ newSquare: Int,
        _ offsets: [Int],
        board: Board
    ) -> Bool {
        let squares: [Int] = board.Squares
        let currentSquarePiece: Piece = squares[currentSquare].piece()
        let newSquarePiece: Piece = squares[newSquare].piece()

        let currentSquarePiecePlayer: Player = player(squares[currentSquare].piece())
        let newSquarePiecePlayer: Player = player(squares[newSquare].piece())

        for offset in offsets {
            if currentSquare + offset == newSquare && newSquarePiecePlayer != currentSquarePiecePlayer {
                return true
            }
        }

        return false
    }

    private func meetsFlags(_ currentSquare: Int, _ newSquare: Int, board: Board, _ offset: MoveOffset) -> Bool {
        let currentSquarePlayer: Player = player(board.Squares[currentSquare].piece())
        let newSquarePlayer: Player = player(board.Squares[newSquare].piece())

        switch offset.flags {
        case .taking: return currentSquarePlayer != newSquarePlayer && newSquarePlayer != .none
        default: return true
        }
    }

    private func offsetIsLegal2(
        _ currentSquare: Int,
        _ newSquare: Int,
        _ offsets: [MoveOffset],
        board: Board
    ) -> Bool {
        let squares: [Int] = board.Squares
        let _: Piece = squares[currentSquare].piece()
        let _: Piece = squares[newSquare].piece()

        let currentSquarePiecePlayer: Player = player(squares[currentSquare].piece())
        let newSquarePiecePlayer: Player = player(squares[newSquare].piece())

        for offset in offsets {
            if
                currentSquare + offset.offset == newSquare &&
                newSquarePiecePlayer != currentSquarePiecePlayer &&
                meetsFlags(currentSquare, newSquare, board: board, offset)
            {
                return true
            }
        }

        return false
    }

    private let whitePawnOffsets2: [MoveOffset] = [.init(-8, .none), .init(-16, .first), .init(-7, .taking), .init(6, .taking)]
    private let whitePawnOffsets: [Int] = [-8, -16]
    private let rookOffsets: [Int] = [-1, 1, -2, 2, -3, 3, -4, 4, -5, 5, -6, 6, -7, 7, 8, -8, 16, -16]

    private let blackPawnOffsets: [Int] = [8, 16]

    var isLegal: Bool

    init(board: Board, currentSquare: Int, newSquare: Int) {
        isLegal = false
        let squares: [Int] = board.Squares

        if currentSquare != newSquare {
            switch squares[currentSquare].piece() {
            case .WhitePawn:
                print("Type: White Pawn")
                print("Move: \(currentSquare) to \(newSquare)")
                print("Difference: \(newSquare - currentSquare)")
                print("Legal offsets: \(whitePawnOffsets)")
                print("Is legal? \(offsetIsLegal(currentSquare, newSquare, whitePawnOffsets, board: board))")
                isLegal = offsetIsLegal2(currentSquare, newSquare, whitePawnOffsets2, board: board)
            case .WhiteRook, .BlackRook:
                isLegal = offsetIsLegal(currentSquare, newSquare, rookOffsets, board: board)
            case .BlackPawn:
                isLegal = offsetIsLegal(currentSquare, newSquare, blackPawnOffsets, board: board)
            default: print(squares[currentSquare].piece())
            }
        }
    }
}

struct MoveOffset: Identifiable, Equatable {
    internal let id: UUID = UUID()
    let offset: Int
    let flags: Flags

    init(_ offset: Int, _ flags: Flags) {
        self.offset = offset
        self.flags = flags
    }

    enum Flags: CaseIterable {
        case none

        case taking
        case first
        case enPassant
    }
}
