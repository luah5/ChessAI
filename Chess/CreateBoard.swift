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
    @State var board: Board

    let width: CGFloat
    let height: CGFloat

    private func createSquare(index: Int) -> some View {
        Button {
            /*
            print("\n--------------")
            print("Move will be: ")
            print(lastSelectedPiece.index, index)
            print("Move's player is \(player(lastSelectedPiece.piece))")
            print("Piece is: \(lastSelectedPiece.piece)")
            print("Move is legal?")
            print(Move(
                board: board,
                currentSquare: lastSelectedPiece,
                newSquare: index
            ).isLegal)
            print("\n--------------")
            */
            if
                LegalMove(
                    board: board,
                    currentSquare: lastSelectedPiece,
                    newSquare: index
                ).isLegal
            {
                board.Squares[index] = lastSelectedPiece.piece.rawValue
                board.Squares[lastSelectedPiece.index] = Piece.None.rawValue
                lastSelectedPiece = ChessPiece(piece: .None, index: 128)

                if board.playerToPlay == .white {
                    board.playerToPlay = .black
                } else {
                    board.playerToPlay = .white
                }
            } else {
                lastSelectedPiece = ChessPiece(piece: board.Squares[index].piece(), index: index)
            }
        } label: {
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
