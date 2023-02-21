//
//  GameSettingsViewModel.swift
//  InfiniteTicTacToe
//
//  Created by Julia Martcenko on 17/02/2023.
//

import Foundation

final class GameSettingsViewModel: ObservableObject {
	@Published private var boardSize: Int = 3

	func setupBoardSize(_ size: Int) {
		boardSize = size
	}
}
