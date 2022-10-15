//
//  GameModel.swift
//  InfiniteTicTacToe
//
//  Created by Julia Martcenko on 14/10/2022.
//

import Foundation

enum Player {
	case crosses
	case circles
}

struct Move {
	let player: Player
	let boardIndex: Int

	var indicator: String {
		player == .circles ? "circle" : "cross"
	}
}

struct GameSettings {
	let crossesPlayer: PlayerIdentity
	let circlesPLayer: PlayerIdentity
	let gameType: GameType

	var boardSize: Int {
		switch gameType {
			case .three:
				return 9
			case .four:
				return 16
			case .five, .infinite:
				return 25
		}
	}

	var boardWidth: Int {
		switch gameType {
			case .three:
				return 3
			case .four:
				return 4
			case .five, .infinite:
				return 5
		}
	}
}

struct PlayerIdentity {
	let playerType: PlayerType
	let playerName: String
}

extension PlayerIdentity {
	static let mockPlayerOne = PlayerIdentity(playerType: .human, playerName: "Vasya")
	static let mockPlayerTwo = PlayerIdentity(playerType: .computer, playerName: "Computer")
}

enum PlayerType {
	case human
	case computer
}

enum GameType {
	case three
	case four
	case five
	case infinite
}
