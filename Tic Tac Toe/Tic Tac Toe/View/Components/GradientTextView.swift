//
//  LogoView.swift
//  Tic Tac Toe
//
//  Created by Malav Soni on 20/01/22.
//

import SwiftUI

struct GradientTextView<Content: View>: View {
    private let gradient = LinearGradient(
        colors: [Color.mark, Color.cross],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        self.content
            .foregroundColor(.clear)
            .background(gradient.mask(self.content))
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        GradientTextView {
            Text("Tic Tac Toe".uppercased())
                .font(.system(size: 45, weight: .bold, design: .rounded))
        }
    }
}
