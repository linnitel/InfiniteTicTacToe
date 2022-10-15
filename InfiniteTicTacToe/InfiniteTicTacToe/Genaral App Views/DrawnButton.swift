//
//  DrawnButton.swift
//  InfiniteTicTacToe
//
//  Created by Julia Martcenko on 15/10/2022.
//

import SwiftUI

struct DrawnButton: View {
	let action: () -> Void
	let title: String

    var body: some View {
		Button(action: {
			self.action()
		}){
			ZStack {
				Image("buttonBackground")
					.resizable()
					.scaledToFit()
					.frame(width: 240, alignment: .center)
				Text("Restart game")
					.fontWeight(.black)
					.foregroundColor(.black)
					.font(.system(size: 20))
					.lineLimit(1)
			}
		}
    }
}
