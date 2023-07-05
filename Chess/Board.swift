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
                Squares.append(fenToPiece(fen: char).rawValue)
            }
        }
    }

    func generateLegalMoves(player: Player) -> [Piece: [Move]] {
        switch player {
        case .none: fatalError("Player cannot be none!")
        case .white: return [.WhitePawn: generateLegalPawnMoves(.white)]
        case .black: return [.BlackPawn: generateLegalPawnMoves(player)]
        }
    }

    private func generateLegalPawnMoves(_ play: Player) -> [Move] {
        var moves: [Move] = []

        var index = 0
        if play == .white {
            for square in self.Squares where player(square.piece()) == play && square.piece() == .WhitePawn {
                for move in whitePawnOffsets.offsets where
                    LegalMove(
                        board: self,
                        currentSquare: ChessPiece(piece: .WhitePawn, index: index),
                        newSquare: move.offset + index
                    ).isLegal
                {
                    moves.append(Move(startPosition: index, endPosition: move.offset + index, type: .WhitePawn))
                }

                index += 1
            }
        } else if play == .black {
            for square in self.Squares where player(square.piece()) == play && square.piece() == .BlackPawn {
                for move in blackPawnOffsets.offsets where
                    LegalMove(
                        board: self,
                        currentSquare: ChessPiece(piece: .BlackPawn, index: index),
                        newSquare: move.offset + index
                    ).isLegal
                {
                    moves.append(Move(startPosition: index, endPosition: move.offset + index, type: .BlackPawn))
                }
            }
        }

        return moves
    }
}

struct Move {
    let startPosition: Int
    let endPosition: Int
    let type: Piece
}
