//
//  Board.swift
//  Chess
//
//  Created by Raymond Vleeshouwer on 01/07/23.
//

import Foundation

class Board {
    public var Squares: [Int]
    public var playerToPlay: Player

    init(fen: String) {
        playerToPlay = .white
        Squares = []

        for character in fen {
            let char: String = String(describing: character)

            if let value = Int(char) {
                for _ in 1...value {
                    Squares.append(0)
                }
            } else if char != "/" {
                Squares.append(Int(fenToPiece(fen: char).rawValue))
            }
        }
    }

    func makeMove(move: Move) {
        self.Squares[move.endPosition] = self.Squares[move.startPosition]
        self.Squares[move.startPosition] = 0

        switch self.playerToPlay {
        case .none: fatalError("Player to play can't be none!")
        case .white: self.playerToPlay = .black
        case .black: self.playerToPlay = .white
        }
    }

    func generateLegalMoves(player: Player) -> [Piece: [Move]] {
        switch player {
        case .none: fatalError("Player cannot be none!")
        case .white:
            return [
                .WhiteKing: generateLegalKingMoves(.white),
                .WhitePawn: generateLegalPawnMoves(.white),
                .WhiteKnight: generateLegalKnightMoves(.white),
                .WhiteBishop: generateLegalBishopMoves(.white),
                .WhiteRook: generateLegalRookMoves(.white),
                .WhiteQueen: generateLegalQueenMoves(.white)
            ]
        case .black:
            return [
                .BlackKing: generateLegalKingMoves(.black),
                .BlackPawn: generateLegalPawnMoves(.black),
                .BlackKnight: generateLegalKnightMoves(.black),
                .BlackBishop: generateLegalBishopMoves(.black),
                .BlackRook: generateLegalRookMoves(.black),
                .BlackQueen: generateLegalQueenMoves(.black)
            ]
        }
    }

    private func generateLegalKingMoves(_ play: Player) -> [Move] {
        var moves: [Move] = []

        var index: Int = 0
        if play == .white {
            for square in self.Squares {
                if
                    player(square.piece()) == .white &&
                    square.piece() == .WhiteKing
                {
                    for move in kingOffsets.offsets where
                        LegalMove(
                            board: self,
                            currentSquare: ChessPiece(piece: .WhiteKing, index: index),
                            newSquare: move.offset + index
                        ).isLegal
                    {
                        moves.append(Move(startPosition: index, endPosition: move.offset + index, type: .WhiteKing))
                    }
                }

                index += 1
            }
        } else if play == .black {
            for square in self.Squares where
                player(square.piece()) == play &&
                square.piece() == .BlackKing
            {
                if
                    player(square.piece()) == play &&
                    square.piece() == .BlackKing
                {
                    for move in kingOffsets.offsets where
                    LegalMove(
                        board: self,
                        currentSquare: ChessPiece(piece: .BlackKing, index: index),
                        newSquare: move.offset + index
                    ).isLegal
                    {
                        moves.append(Move(startPosition: index, endPosition: move.offset + index, type: .BlackKing))
                    }
                }
            }

            index += 1
        }

        return moves
    }

    private func generateLegalPawnMoves(_ play: Player) -> [Move] {
        var moves: [Move] = []

        var index = 0
        if play == .white {
            for square in self.Squares {
                if
                    player(square.piece()) == play &&
                    square.piece() == .WhitePawn
                {
                    for move in whitePawnOffsets.offsets where
                        LegalMove(
                            board: self,
                            currentSquare: ChessPiece(piece: .WhitePawn, index: index),
                            newSquare: move.offset + index
                        ).isLegal
                    {
                        moves.append(Move(startPosition: index, endPosition: move.offset + index, type: .WhitePawn))
                    }
                }

                index += 1
            }
        } else if play == .black {
            for square in self.Squares {
                if
                    player(square.piece()) == play &&
                    square.piece() == .BlackPawn
                {
                    for move in blackPawnOffsets.offsets where
                        LegalMove(
                            board: self,
                            currentSquare: ChessPiece(piece: .BlackPawn, index: index),
                            newSquare: move.offset + index
                        ).isLegal
                    {
                        moves.append(
                            Move(
                                startPosition: index,
                                endPosition: move.offset + index,
                                type: .BlackPawn
                            )
                        )
                    }
                }

                index += 1
            }
        }

        return moves
    }

    private func generateLegalKnightMoves(_ play: Player) -> [Move] {
        var moves: [Move] = []

        var index = 0
        if play == .white {
            for square in self.Squares {
                if
                    player(square.piece()) == .white &&
                    square.piece() == .WhiteKnight
                {
                    for move in knightOffsets.offsets where
                    LegalMove(
                        board: self,
                        currentSquare: ChessPiece(piece: .WhiteKnight, index: index),
                        newSquare: move.offset + index
                    ).isLegal
                    {
                        moves.append(
                            Move(
                                startPosition: index,
                                endPosition: move.offset + index,
                                type: .WhiteKnight
                            )
                        )
                    }
                }

                index += 1
            }
        } else if play == .black {
            for square in self.Squares {
                if
                    player(square.piece()) == play &&
                    square.piece() == .BlackKnight
                {
                    for move in knightOffsets.offsets where
                        LegalMove(
                            board: self,
                            currentSquare: ChessPiece(piece: .BlackKnight, index: index),
                            newSquare: move.offset + index
                        ).isLegal
                    {
                        moves.append(
                            Move(
                                startPosition: index,
                                endPosition: move.offset + index,
                                type: .BlackKnight
                            )
                        )
                    }
                }

                index += 1
            }
        }

        return moves
    }

    private func generateLegalBishopMoves(_ play: Player) -> [Move] {
        var moves: [Move] = []

        var index = 0
        if play == .white {
            for square in self.Squares where
                player(square.piece()) == .white &&
                square.piece() == .WhiteBishop
            {
                for move in bishopOffsets.offsets where
                    LegalMove(
                        board: self,
                        currentSquare: ChessPiece(piece: .WhiteBishop, index: index),
                        newSquare: move.offset + index
                    ).isLegal
                {
                    moves.append(
                        Move(
                            startPosition: index,
                            endPosition: move.offset + index,
                            type: .WhiteBishop
                        )
                    )
                }

                index += 1
            }
        } else if play == .black {
            for square in self.Squares where
                player(square.piece()) == play &&
                square.piece() == .BlackBishop
            {
                for move in bishopOffsets.offsets where
                    LegalMove(
                        board: self,
                        currentSquare: ChessPiece(piece: .BlackBishop, index: index),
                        newSquare: move.offset + index
                    ).isLegal
                {
                    moves.append(
                        Move(
                            startPosition: index,
                            endPosition: move.offset + index,
                            type: .BlackBishop
                        )
                    )
                }
            }
        }

        return moves
    }

    private func generateLegalRookMoves(_ play: Player) -> [Move] {
        var moves: [Move] = []

        var index = 0
        if play == .white {
            for square in self.Squares where
                player(square.piece()) == .white &&
                square.piece() == .WhiteRook
            {
                for move in rookOffsets.offsets where
                    LegalMove(
                        board: self,
                        currentSquare: ChessPiece(piece: .WhiteRook, index: index),
                        newSquare: move.offset + index
                    ).isLegal
                {
                    moves.append(
                        Move(
                            startPosition: index,
                            endPosition: move.offset + index - 1,
                            type: .WhiteRook
                        )
                    )
                }

                index += 1
            }
        } else if play == .black {
            for square in self.Squares where
                player(square.piece()) == play &&
                square.piece() == .BlackRook
            {
                for move in rookOffsets.offsets where
                    LegalMove(
                        board: self,
                        currentSquare: ChessPiece(piece: .BlackRook, index: index),
                        newSquare: move.offset + index
                    ).isLegal
                {
                    moves.append(
                        Move(
                            startPosition: index,
                            endPosition: move.offset + index,
                            type: .BlackRook
                        )
                    )
                }
            }
        }

        return moves
    }

    private func generateLegalQueenMoves(_ play: Player) -> [Move] {
        var moves: [Move] = []

        var index = 0
        if play == .white {
            for square in self.Squares where
                player(square.piece()) == .white &&
                square.piece() == .WhiteQueen
            {
                for move in queenOffsets.offsets where
                    LegalMove(
                        board: self,
                        currentSquare: ChessPiece(piece: .WhiteQueen, index: index),
                        newSquare: move.offset + index
                    ).isLegal
                {
                    moves.append(
                        Move(
                            startPosition: index,
                            endPosition: move.offset + index,
                            type: .WhiteQueen
                        )
                    )
                }

                index += 1
            }
        } else if play == .black {
            for square in self.Squares where
                player(square.piece()) == play &&
                square.piece() == .BlackQueen
            {
                for move in queenOffsets.offsets where
                    LegalMove(
                        board: self,
                        currentSquare: ChessPiece(piece: .BlackQueen, index: index),
                        newSquare: move.offset + index
                    ).isLegal
                {
                    moves.append(
                        Move(
                            startPosition: index,
                            endPosition: move.offset + index,
                            type: .BlackQueen
                        )
                    )
                }
            }
        }

        return moves
    }
}
