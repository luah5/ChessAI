//
//  CreateBoard.swift
//  Chess
//
//  Created by Raymond Vleeshouwer on 01/07/23.
//

import SwiftUI

struct CreateBoard: View {
    @State private var lastSelectedPiece: ChessPiece = ChessPiece(piece: .None, index: 128)
    @State private var toPlay: Player = .white
    var board: Board

    let width: CGFloat
    let height: CGFloat

    init(board: Board, width: CGFloat, height: CGFloat) {
        self.board = board
        self.width = width
        self.height = height

        Engine(board: self.board, color: .black)
    }

    private func createSquare(index: Int) -> some View {
        Button {
            print("\n--------------")
            print("Move will be: ")
            print(lastSelectedPiece.index, index)
            print("Move's player is \(player(lastSelectedPiece.piece))")
            print("Piece is: \(lastSelectedPiece.piece)")
            print("Move is legal")
            print(LegalMove(
                board: board,
                currentSquare: lastSelectedPiece,
                newSquare: index
            ).isLegal)
            print("\n--------------")
            if
                LegalMove(
                    board: board,
                    currentSquare: lastSelectedPiece,
                    newSquare: index
                ).isLegal
            {
                board.makeMove(
                    move: Move(
                        startPosition: lastSelectedPiece.index,
                        endPosition: index,
                        type: lastSelectedPiece.piece
                    )
                )
                lastSelectedPiece = ChessPiece(piece: .None, index: 128)
            } else {
                lastSelectedPiece = ChessPiece(piece: board.Squares[index].piece(), index: index)
            }
        } label: {
            ZStack {
                pieceToImage(
                    board.Squares[index]
                        .piece()
                )
                .resizable()
                .frame(width: width / 64, height: height / 64)
                .foregroundStyle(.red)
                .background(
                    (((index % 8) + 1) + (index / 8) + 1) % 2 == 0 ?
                        .primarySquare : .secondarySquare
                )
                .brightness(
                    lastSelectedPiece.index == index &&
                    lastSelectedPiece.piece == board.Squares[index].piece()
                    ? 0.2: 0
                )
                Text(String(describing: index))
                    .foregroundStyle(.red)
            }
        }
        .buttonStyle(.plain)
    }

    var body: some View {
        ForEach(0...(board.Squares.count - 1), id: \.self) { index in
            Spacer().frame(height: 0)
            if index % 8 == 0 && index != board.Squares.count - 1 {
                HStack(spacing: 0) {
                    ForEach(1...8, id: \.self) { rank in
                        createSquare(index: index + (rank - 1))
                    }
                }
            }
        }
    }
}

let board = Board(fen: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR")
#Preview {
    CreateBoard(board: board, width: 4000, height: 4000)
}
