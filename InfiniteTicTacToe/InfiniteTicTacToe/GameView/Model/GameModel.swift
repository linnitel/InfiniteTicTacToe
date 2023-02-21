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

enum GameType {
	case three
	case four
	case five

	init(from type: String) {
		if type == "3" {
			self = .three
		} else if type == "4" {
			self = .four
		} else {
			self = .five
		}
	}

	var string: String {
		switch self {
			case .three:
				return "3"
			case .four:
				return "4"
			case .five:
				return "5"
		}
	}
}

struct Move {
	let player: Player
	let boardIndex: Int

	var indicator: String {
		player == .circles ? "circle" : "cross"
	}
}

struct GameSettings {
	var crossesPlayer: PlayerType
	var circlesPLayer: PlayerType
	var gameType: GameType

	var boardSize: Int {
		switch gameType {
			case .three:
				return 9
			case .four:
				return 16
			case .five:
				return 25
		}
	}

	var boardWidth: Int {
		switch gameType {
			case .three:
				return 3
			case .four:
				return 4
			case .five:
				return 5
		}
	}
}

struct PlayerIdentity {
	let playerType: PlayerType
	let playerName: String
}

extension PlayerType {
	static let mockPlayerOne: PlayerType = .human
	static let mockPlayerTwo: PlayerType = .computer
}

enum PlayerType: Equatable {
	case human
	case computer

	var string: String {
		switch self {
			case .human:
				return "Human"
			case .computer:
				return "Computer"
		}
	}

	init(from type: String) {
		self = type == "Human" ? .human : .computer
	}
}
