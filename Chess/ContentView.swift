//
//  ContentView.swift
//  Chess
//
//  Created by Raymond Vleeshouwer on 01/07/23.
//

import SwiftUI

struct ContentView: View {
    @State var board = Board(
        fen: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR"
    )

    var body: some View {
        HStack {
            Spacer()
                .frame(width: 10)
            VStack {
                Spacer()
                    .frame(height: 10)
                CreateBoard(
                    board: board,
                    width: 4000,
                    height: 4000
                )
                Spacer()
                    .frame(height: 10)
            }
            Spacer()
                .frame(width: 10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
