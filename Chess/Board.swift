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
}
