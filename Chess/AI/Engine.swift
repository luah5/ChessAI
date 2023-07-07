//
//  Engine.swift
//  Chess
//
//  Created by Raymond Vleeshouwer on 06/07/23.
//

import Foundation

class Engine {
    var board: Board
    let color: Player
    
    init(board: Board, color: Player) {
        self.board = board
        self.color = color
        
        DispatchQueue.global(qos: .userInteractive).async {
            while (true) {
                if board.playerToPlay == self.color {
                    let moves: [Piece: [Move]] = board.generateLegalMoves(player: .black)
                    var suggestedMove: Move = Move(startPosition: 0, endPosition: 1, type: .BlackPawn)
                    let nilMove: Move = Move(startPosition: 0, endPosition: 1, type: .BlackPawn)
                    var highestEval: Int = .min

                    for piece in moves {
                        for move in piece.value {
                            if suggestedMove == nilMove {
                                suggestedMove = move
                            }

                            switch board.Squares[move.endPosition].piece() {
                            case .WhitePawn:
                                if highestEval < 1 {
                                    highestEval = 1
                                    suggestedMove = move
                                }
                            case .WhiteBishop, .WhiteKnight:
                                if highestEval < 3 {
                                    highestEval = 3
                                    suggestedMove = move
                                }
                            case .WhiteRook:
                                if highestEval < 5 {
                                    highestEval = 5
                                    suggestedMove = move
                                }
                            case .WhiteQueen:
                                if highestEval < 9 {
                                    highestEval = 9
                                    suggestedMove = move
                                }
                            case .WhiteKing:
                                if highestEval < .max {
                                    highestEval = .max
                                    suggestedMove = move
                                }
                            default: highestEval = .min
                            }
                        }
                    }
                    
                    board.makeMove(move: suggestedMove)
                }
                
                usleep(10000)
            }
        }
    }
    
    private func evaluate() {

    }
}
