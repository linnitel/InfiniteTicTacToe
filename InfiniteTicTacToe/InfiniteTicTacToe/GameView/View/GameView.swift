//
//  GameView.swift
//  InfiniteTicTacToe
//
//  Created by Julia Martcenko on 14/10/2022.
//

import SwiftUI

let columns: [GridItem] = [GridItem(.flexible()),
						   GridItem(.flexible()),
						   GridItem(.flexible())]

struct GameView: View {
	@State private var gameSettings = GameSettings(
		crossesPlayer: PlayerIdentity.mockPlayerOne,
		circlesPLayer: PlayerIdentity.mockPlayerTwo,
		gameType: .three
	)

	@State private var moves: [Move?] = Array(repeating: nil, count: 9)
	@State private var isCrossesTurn: Bool = true
	@State private var isBoardDisables: Bool = false

	var body: some View {

		GeometryReader { geometry in
			VStack(spacing: 40) {
				Spacer()
				HStack {
					PlayerDiscriptionView(
						playerOrder: 1,
						playerName: self.gameSettings.crossesPlayer.playerName
					)
					.frame(maxWidth: geometry.size.width / 2 - 5)
					Spacer()
					PlayerDiscriptionView(
						playerOrder: 2,
						playerName: self.gameSettings.circlesPLayer.playerName
					)
					.frame(maxWidth: geometry.size.width / 2 - 5)
				}
				LazyVGrid(columns: columns) {
					ForEach(0..<9) { index in
						ZStack {
							let width = geometry.size.width / 3 - 15
							Image("squaresBackground")
								.resizable()
								.frame(
									width: width,
									height: width
								)
							if let indicator = self.moves[index]?.indicator {
								Image(indicator)
									.resizable()
									.frame(width: width / 3, height: width / 3)
							}
						}
						.onTapGesture {
							guard !isSquareOccupied(in: self.moves, for: index) else {
								return
							}
							self.moves[index] = Move(
								player: self.isCrossesTurn ? .crosses : .circles,
								boardIndex: index
							)
							if self.gameSettings.circlesPLayer.playerType == .computer {
								self.isBoardDisables = true
							}
							self.isCrossesTurn.toggle()

							DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
								let computerPosition = self.determinComputerMovePosition(in: moves)
								moves[computerPosition] = Move(
									player: .circles,
									boardIndex: computerPosition
								)
							}
							if self.gameSettings.circlesPLayer.playerType == .computer {
								self.isBoardDisables = false
							}
							self.isCrossesTurn.toggle()
						}
					}
				}
				.disabled(self.isBoardDisables)
				DrawnButton(action: self.restartGame, title: "Restart game")
				Spacer()
			}
			.padding()
		}
	}

	func isSquareOccupied(in moves: [Move?], for index: Int) -> Bool {
		moves.contains(where: { $0?.boardIndex == index })
	}

	func determinComputerMovePosition(in moves: [Move?]) -> Int {
		var movePosition = Int.random(in: 0..<9)

		while self.isSquareOccupied(in: moves, for: movePosition) {
			movePosition = Int.random(in: 0..<9)
		}
		return movePosition
	}

	func restartGame() {
		self.moves = Array(repeating: nil, count: 9)
		self.isBoardDisables = false
	}
}


struct PlayerDiscriptionView: View {
	let playerOrder: Int
	let playerName: String

	var body: some View {
		VStack(alignment: .leading) {
			Text("Player \(playerOrder):")
				.fontWeight(.black)
				.font(.system(size: 20))
				.lineLimit(1)
			Text(playerName)
				.lineLimit(3)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		GameView()
    }
}
