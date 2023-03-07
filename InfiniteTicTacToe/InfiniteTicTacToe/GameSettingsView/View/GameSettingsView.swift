//
//  GameSettingsView.swift
//  InfiniteTicTacToe
//
//  Created by Julia Martcenko on 17/02/2023.
//

import SwiftUI

struct GameSettingsView: View {
//	@StateObject var viewModel: GameSettingsViewModel

	@State var gameSettings: GameSettings

	var body: some View {
		NavigationView {
			VStack {
				HStack(spacing: 20) {
					PlayerSettingView(title: "Player 1:", identity: $gameSettings.crossesPlayer, secondPlayerIdentity: $gameSettings.circlesPLayer)
					PlayerSettingView(title: "Player 2:", identity: $gameSettings.circlesPLayer, secondPlayerIdentity: $gameSettings.crossesPlayer)
				}
				.padding()
				GameSizeView(title: "Board Size:", selectedGame: $gameSettings.gameType, selected: gameSettings.gameType.string)
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
		GameSettingsView(gameSettings: GameSettings(crossesPlayer: .human, circlesPLayer: .computer, gameType: .four))
    }
}

struct PlayerSettingView: View {
	let title: String
	@Binding var identity: PlayerType
	@Binding var secondPlayerIdentity: PlayerType

	var body: some View {
		VStack {
			HeaderTextView(title: self.title)
			HStack(spacing: 10) {
				OptionsPlayerView(title: "Human", gameType: $identity, secondPlayerType: self.$secondPlayerIdentity)
				OptionsPlayerView(title: "Computer", gameType: $identity, secondPlayerType: self.$secondPlayerIdentity)
			}
			.padding(.top, 10)
		}
	}
}

struct GameSizeView: View {
	let title: String
	@Binding var selectedGame: GameType
	@State var selected: String

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
						width: 60,
						height: 60
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

struct OptionButton: View {
	let title: String
	let font: Font

	@Binding var gameType: PlayerType
	@Binding var secondPlayerType: PlayerType

	var body: some View {
		Button (action: {
			self.gameType = PlayerType(from: self.title)
			if self.secondPlayerType == .computer, self.gameType == .computer {
				self.secondPlayerType = .human
			}
		}) {
			Text(self.title)
				.font(self.font)
				.lineLimit(3)
		}
		.foregroundColor(.black)
	}
}

struct OptionsPlayerView: View {
	let title: String
	@Binding var gameType: PlayerType
	@Binding var secondPlayerType: PlayerType

	var body: some View {
		if gameType.string == title {
			OptionButton(title: self.title, font: Font.headline, gameType: self.$gameType, secondPlayerType: self.$secondPlayerType)
		} else {
			OptionButton(title: self.title, font: Font.body, gameType: self.$gameType, secondPlayerType: self.$secondPlayerType)
		}
	}
}
