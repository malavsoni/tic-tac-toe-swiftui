//
//  ActionMenu.swift
//  Tic Tac Toe
//
//  Created by Malav Soni on 20/01/22.
//

import SwiftUI

struct ActionMenu: View {
    let message:String
    let onSettingsTap:() -> Void
    let onResetGameTap:() -> Void
    
    var body: some View {
        HStack {
            Button(action: self.onSettingsTap) {
                Image(systemName: "gear")
                    .font(.largeTitle)
                    .padding(4.0)
                    .background(Circle().fill(Color.secondaryColor))
                    .foregroundColor(Color.white)
            }.accessibilityIdentifier("Settings_Identifier")
            
            Text(self.message)
                .fontWeight(.black)
                .foregroundColor(Color.secondaryColor)
                .padding(.horizontal)
                .padding(.vertical, 8.0)
                .overlay(
                    Capsule()
                        .stroke(Color.secondaryColor.opacity(0.5), lineWidth: 2)
                )
                .frame(maxWidth:.infinity)
                .accessibilityIdentifier("Message_Identifier")
            
            Button(action: self.onResetGameTap) {
                Image(systemName: "goforward")
                    .font(.largeTitle)
                    .padding(4.0)
                    .background(Circle().fill(Color.secondaryColor))
                    .foregroundColor(Color.white)
            }.accessibilityIdentifier("Reset_Game_Identifier")
        }
    }
}

struct ActionMenu_Previews: PreviewProvider {
    static var previews: some View {
        ActionMenu(message: "Player A Won.") {
            
        } onResetGameTap: {
            
        }

    }
}
