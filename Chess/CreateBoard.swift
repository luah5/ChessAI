//
//  CreateBoard.swift
//  Chess
//
//  Created by Raymond Vleeshouwer on 01/07/23.
//

import SwiftUI

struct CreateBoard: View {
    @State private var lastSelectedPiece: ChessPiece = ChessPiece(piece: .None, index: 0)
    @State private var toPlay: Player = .white
    @State var board: Board
    @State var squares: [Int]

    let width: CGFloat
    let height: CGFloat

    private func createSquare(index: Int) -> some View {
        Button {
            if lastSelectedPiece.piece == .None {
                lastSelectedPiece = ChessPiece(piece: squares[index].piece(), index: index)
            } else if
                Move(
                    board: board,
                    currentSquare: lastSelectedPiece.index,
                    newSquare: index
                ).isLegal
            {
                squares[index] = lastSelectedPiece.piece.rawValue
                squares[lastSelectedPiece.index] = Piece.None.rawValue
                lastSelectedPiece.index = 0

                if toPlay == .white {
                    toPlay = .black
                } else {
                    toPlay = .white
                }
            } else {
                print("clicked and setting to \(squares[index].piece())")
                lastSelectedPiece = ChessPiece(
                    piece: squares[index].piece(),
                    index: index
                )
            }
        } label: {
            pieceToImage(
                squares[index]
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
                lastSelectedPiece.piece == squares[index].piece()
                        ? 0.2: 0
            )
        }
        .buttonStyle(.plain)
    }

    var body: some View {
        ForEach(0...(squares.count - 1), id: \.self) { index in
            Spacer().frame(height: 0)
            if index % 8 == 0 && index != squares.count - 1 {
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
    CreateBoard(board: board, squares: board.Squares, width: 4000, height: 4000)
}
