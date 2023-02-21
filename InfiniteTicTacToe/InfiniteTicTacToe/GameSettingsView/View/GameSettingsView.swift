//
//  GameSettingsView.swift
//  InfiniteTicTacToe
//
//  Created by Julia Martcenko on 17/02/2023.
//

import SwiftUI

struct GameSettingsView: View {
	@StateObject var viewModel: GameSettingsViewModel

	@State var gameSettings = GameSettings(crossesPlayer: .human, circlesPLayer: .computer, gameType: .three)

//	@State var playerOneIdentity: PlayerType = .human
//	@State var playerTwoIdentity: PlayerType = .computer
//	@State var gameType: GameType = .three

	var body: some View {
		NavigationView {
			VStack {
				HStack(spacing: 20) {
					PlayerSettingView(title: "Player 1:", identity: $gameSettings.crossesPlayer, selected: gameSettings.crossesPlayer.string)
					PlayerSettingView(title: "Player 2:", identity: $gameSettings.circlesPLayer, selected: gameSettings.circlesPLayer.string)
				}
				.padding()
				GameSizeView(title: "Board Size:", selectedGame: $gameSettings.gameType)
					.padding(.bottom)
				NavigationLink(destination: GameView(gameSettings: $gameSettings)) {
					NavigationButtonView(title: "Start")
				}
			}
		}
		.navigationBarTitle("")
		.navigationBarHidden(true)
	}
}

struct GameSettingsView_Previews: PreviewProvider {
    static var previews: some View {
//		GameSettingsView(viewModel: GameSettingsViewModel(), playerOneIdentity: .human, playerTwoIdentity: .computer)
		GameSettingsView(viewModel: GameSettingsViewModel())
    }
}

struct PlayerSettingView: View {
	let title: String
	@Binding var identity: PlayerType
	@State var selected: String

	var body: some View {
		VStack {
			HeaderTextView(title: self.title)
			HStack(spacing: 10) {
				OptionsPlayerView(title: "Human", gameType: $identity)
				OptionsPlayerView(title: "Computer", gameType: $identity)
			}
			.padding(.top, 10)
		}
	}
}

struct GameSizeView: View {
	let title: String
	@Binding var selectedGame: GameType
	@State var selected: String = "3"

	var body: some View {
		VStack {
			HeaderTextView(title: self.title)
			HStack(spacing: 30) {
				OptionsTextView(title: "3", selected: $selected)
				OptionsTextView(title: "4", selected: $selected)
				OptionsTextView(title: "5", selected: $selected)
			}
			.padding(.top, 10)
		}
	}
}

struct HeaderTextView: View {
	let title: String

	var body: some View {
		Text(self.title)
			.fontWeight(.black)
			.font(.system(size: 20))
			.lineLimit(1)
	}
}

struct OptionsTextView: View {
	let title: String
	@Binding var selected: String

	var body: some View {
		if selected == title {
			ZStack {
				Image("squaresBackground")
					.resizable()
					.frame(
						width: 40,
						height: 40
					)
				Button (action: { self.selected = self.title }) {
					Text(self.title)
						.font(Font.headline)
						.lineLimit(3)
				}
				.foregroundColor(.black)
			}
		} else {
			Button (action: { self.selected = self.title }) {
				Text(self.title)
					.lineLimit(3)
			}
			.foregroundColor(.black)
		}
	}
}

struct OptionsPlayerView: View {
	let title: String
	@Binding var gameType: PlayerType

	var body: some View {
		if gameType.string == title {
			Button (action: { self.gameType = PlayerType(from: self.title) }) {
				Text(self.title)
					.font(Font.headline)
					.lineLimit(3)
			}
			.foregroundColor(.black)
		} else {
			Button (action: { self.gameType = PlayerType(from: self.title) }) {
				Text(self.title)
					.lineLimit(3)
			}
			.foregroundColor(.black)
		}
	}
}
