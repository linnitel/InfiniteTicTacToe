//
//  NavigationButtonView.swift
//  InfiniteTicTacToe
//
//  Created by Julia Martcenko on 17/02/2023.
//

import SwiftUI

struct NavigationButtonView: View {
	@State var title: String

    var body: some View {
		ZStack {
			Image("buttonBackground")
				.resizable()
				.scaledToFit()
				.frame(width: 240, alignment: .center)
			Text(self.title)
				.fontWeight(.black)
				.foregroundColor(.black)
				.font(.system(size: 20))
				.lineLimit(1)
		}
    }
}

struct NavigationButtonView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationButtonView(title: "Start")
    }
}
