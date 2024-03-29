//
//  InfiniteTicTacToeApp.swift
//  InfiniteTicTacToe
//
//  Created by Julia Martcenko on 14/10/2022.
//

import SwiftUI

@main
struct InfiniteTicTacToeApp: App {
    var body: some Scene {
        WindowGroup {
			let gameSettings = GameSettings(crossesPlayer: .human, circlesPLayer: .computer, gameType: .three)
			GameSettingsView(gameSettings: gameSettings)
        }
    }
}
