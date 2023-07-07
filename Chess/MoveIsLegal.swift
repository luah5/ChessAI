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
        case .none:
            return board.Squares[newSquare].piece() == .None
        case .pawnFirst:
            return board.Squares[newSquare].piece() == .None &&
                   currentSquarePlayer == .white ? currentSquare >= 48 &&
                   currentSquare <= 55 : currentSquare >= 8 &&
                   currentSquare <= 15
        case .taking:
            return currentSquarePlayer != newSquarePlayer && board.Squares[newSquare].piece() != .None
        case .takingOptional:
            return board.Squares[newSquare].piece() == .None ||
                   (currentSquarePlayer != newSquarePlayer && board.Squares[newSquare].piece() != .None)
        default: return true
        }
    }

    private func offsetIsLegal(
        _ currentSquare: Int,
        _ newSquare: Int,
        _ moveOffsets: MoveOffsets
    ) -> Bool {
        if newSquare > 63 || newSquare < 0 {
            return false
        }

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
                print("met flags")
                if !moveOffsets.canJumpOverPieces {
                    if offset.direction == .vertical {
                        for valueOffset in range2(currentSquare, 8, newSquare) {
                            if squares[currentSquare + valueOffset].piece() != .None {
                                print("failed vertical, value was: \(squares[currentSquare + valueOffset].piece()) at index \(currentSquare + valueOffset) and valueOffset was \(valueOffset)")
                                return false
                            }
                        }
                    } else if offset.direction == .horizontal {
                        for valueOffset in range2(currentSquare, 1, newSquare) {
                            if squares[valueOffset + valueOffset].piece() != .None {
                                print("failed horizontal, value was: \(squares[currentSquare + valueOffset].piece()) at index \(currentSquare + valueOffset) and valueOffset was \(valueOffset)")
                                return false
                            }
                        }
                    }
                }

                print("success on latest move")
                return true
            } else {
                if currentSquare + offset.offset <= 63 && currentSquare + offset.offset >= 0 && !moveOffsets.canJumpOverPieces {
                    if
                        player(squares[currentSquare + offset.offset].piece()) == player(squares[currentSquare].piece())
                    {
                        print("return false, because of obstruction")
                        return false
                    }
                }
                // print("failed flags, \(currentSquarePiece)")
            }
        }

        return false
    }

    private func canAttackSquare(
        piece: ChessPiece,
        square: Int
    ) -> Bool {
        switch piece.piece {
        case .None: fatalError("Code 1: Piece can't be none!")
        case .WhitePawn:
            for offset in whitePawnOffsets.offsets where
                offsetIsLegal(piece.index, piece.index + offset.offset, whitePawnOffsets) &&
                piece.index + offset.offset == square {
                return true
            }
        case .BlackPawn:
            for offset in blackPawnOffsets.offsets where
                offsetIsLegal(piece.index, piece.index + offset.offset, blackPawnOffsets) &&
                piece.index + offset.offset == square {
                return true
            }
        case .WhiteRook, .BlackRook:
            for offset in rookOffsets.offsets where
                offsetIsLegal(piece.index, piece.index + offset.offset, rookOffsets) &&
                piece.index + offset.offset == square {
                return true
            }
        case .WhiteKnight, .BlackKnight:
            for offset in knightOffsets.offsets where
                offsetIsLegal(piece.index, piece.index + offset.offset, knightOffsets) &&
                piece.index + offset.offset == square {
                return true
            }
        case .WhiteKing, .BlackKing:
            for offset in kingOffsets.offsets where
                offsetIsLegal(piece.index, piece.index + offset.offset, kingOffsets) &&
                piece.index + offset.offset == square {
                return true
            }
        case .WhiteBishop, .BlackBishop:
            for offset in bishopOffsets.offsets where
                offsetIsLegal(piece.index, piece.index + offset.offset, bishopOffsets) &&
                piece.index + offset.offset == square {
                return true
            }
        case .WhiteQueen, .BlackQueen:
            for offset in queenOffsets.offsets where
                offsetIsLegal(piece.index, piece.index + offset.offset, queenOffsets) &&
                piece.index + offset.offset == square {
                return true
            }
        }

        return false
    }

    func isInCheck(color: Player) -> Bool {
        var index: UInt8 = 0
        var square: Int = 0

        switch color {
        case .none: fatalError("What? Who are you? How did you get here?")
        case .white: square = self.board.Squares.firstIndex(of: Int(Piece.WhiteKing.rawValue)) ?? 0
        case .black: square = self.board.Squares.firstIndex(of: Int(Piece.BlackKing.rawValue)) ?? 0
        }

        for square in self.board.Squares {
            if
                square.piece() != .None &&
                color == .white ? square.piece() != .WhiteKing : square.piece() != .BlackKing
            {
                return canAttackSquare(
                    piece: ChessPiece(piece: square.piece(), index: Int(index)),
                    square: square
                )
            }

            index += 1
        }

        return false
    }

    var isLegal: Bool
    var board: Board

    init(board: Board, currentSquare: ChessPiece, newSquare: Int) {
        print("move: \(currentSquare.index) to \(newSquare)")
        if currentSquare.index > 63 || currentSquare.index < 0 || newSquare > 63 || newSquare < 0 {
            self.board = board
            self.isLegal = false
            return
        }

        let currentIndex: Int = currentSquare.index
        self.board = board
        self.isLegal = false

        print(currentSquare, board.playerToPlay)
        if
            currentSquare.index != newSquare &&
            currentSquare.piece != .None &&
            board.playerToPlay == player(currentSquare.piece) /*&& !isInCheck(color: player(currentSquare.piece))*/
        {
            switch currentSquare.piece {
            case .None: isLegal = false

            case .WhitePawn: isLegal = offsetIsLegal(currentIndex, newSquare, whitePawnOffsets)
            case .BlackPawn: isLegal = offsetIsLegal(currentIndex, newSquare, blackPawnOffsets)
            case .WhiteRook, .BlackRook: isLegal = offsetIsLegal(currentIndex, newSquare, rookOffsets)
            case .WhiteKnight, .BlackKnight: isLegal = offsetIsLegal(currentIndex, newSquare, knightOffsets)
            case .WhiteKing, .BlackKing: isLegal = offsetIsLegal(currentIndex, newSquare, kingOffsets)
            case .WhiteBishop, .BlackBishop: isLegal = offsetIsLegal(currentIndex, newSquare, bishopOffsets)
            case .WhiteQueen, .BlackQueen: isLegal = offsetIsLegal(currentIndex, newSquare, queenOffsets)
            }
        }

        print("fail")
    }
}
