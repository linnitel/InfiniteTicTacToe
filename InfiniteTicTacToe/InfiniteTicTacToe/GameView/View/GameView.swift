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
	@Binding var gameSettings: GameSettings
//	@State var gameSettings: GameSettings

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
						playerName: self.gameSettings.crossesPlayer.string
					)
					.frame(maxWidth: geometry.size.width / 2 - 5)
					Spacer()
					PlayerDiscriptionView(
						playerOrder: 2,
						playerName: self.gameSettings.circlesPLayer.string
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
							if self.gameSettings.circlesPLayer == .computer {
								self.isBoardDisables = true
							}
							self.isCrossesTurn.toggle()

							if self.isWinCondition(for: .crosses, in: moves) {
								print("\(self.gameSettings.crossesPlayer.string) wins!")
								return
							}

							if isDrawCondition(in: moves) {
								print("Draw!")
								return
							}

							DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {

								let computerPosition = self.determinComputerMovePosition(in: moves)
								moves[computerPosition] = Move(
									player: .circles,
									boardIndex: computerPosition
								)

								if self.isWinCondition(for: .circles, in: moves) {
									print("\(self.gameSettings.circlesPLayer.string) wins!")
									return
								}

								if self.gameSettings.circlesPLayer == .computer {
									self.isBoardDisables = false
								}

								self.isCrossesTurn.toggle()

								if isDrawCondition(in: moves) {
									print("Draw!")
									return
								}
							}
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
		self.isCrossesTurn = true
	}

	func isWinCondition(for player: Player, in moves: [Move?]) -> Bool {
		let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

		let playerMoves = moves.compactMap { $0 }
			.filter {$0.player == player }
		let playerPositions = Set(playerMoves.map { $0.boardIndex })

		for pattern in winPatterns where pattern.isSubset(of: playerPositions) {
			return true
		}

		return false
	}

	func isDrawCondition(in moves: [Move?]) -> Bool {
		self.moves.compactMap({ $0 }).count == 9
	}
}


struct PlayerDiscriptionView: View {
	let playerOrder: Int
	let playerName: String

	var body: some View {
		VStack(alignment: .leading) {
			Text("Player \(self.playerOrder):")
				.fontWeight(.black)
				.font(.system(size: 20))
				.lineLimit(1)
			Text(self.playerName)
				.lineLimit(3)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		GameView(gameSettings: .constant(GameSettings(crossesPlayer: .human, circlesPLayer: .computer, gameType: .five)))
    }
}
