//
//  BoardGridView.swift
//  Tic Tac Toe
//
//  Created by Malav Soni on 20/01/22.
//

import SwiftUI

struct BoardGridView: View {
    private let columnsSettings:[GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let boxes:[BoxState?]
    let onTap:(Int) -> Void
    
    var body: some View {
        LazyVGrid(columns: self.columnsSettings) {
            ForEach(0..<self.boxes.count, id:\.self) { index in
                BoardBoxView(state: self.boxes[index]) {
                    self.onTap(index)
                }
            }
        }
    }
}

struct BoardBoxView: View {
    
    @State private var blinkState:Bool = true
    
    let state:BoxState?
    let onTapAction:() -> Void
    
    var body: some View {
        ZStack {
            if let state = state {
                RoundedRectangle(cornerRadius: 10, style: .circular)
                    .stroke(style: StrokeStyle(lineWidth: 4))
                    .foregroundColor(state.color)
                    
                
                Image(systemName: state.systemImage)
                    .resizable()
                    .foregroundColor(state.color)
                    .padding()

            } else {
                RoundedRectangle(cornerRadius: 10, style: .circular)
                    .stroke(style: StrokeStyle(lineWidth: 4, dash: [state != nil ? 1 : 7.5]))
                    .foregroundColor((state != nil ? state!.color : .secondaryColor).opacity(blinkState ? 1.0 : 0.5))
                    .cornerRadius(10.0)
                    .animation(Animation.easeInOut(duration:0.75).repeatForever(autoreverses:true))
            }
        }
        .aspectRatio(1.0, contentMode: ContentMode.fill)
        .frame(maxWidth:.infinity,maxHeight:.infinity)
        .onAppear {
            if (state == nil) {
                self.blinkState.toggle()
            }
        }
        .background(Color.white)
        .cornerRadius(10.0)
        .contentShape(Rectangle())
        .onTapGesture(perform: self.onTapAction)
    }
}

struct BoardGridView_Previews: PreviewProvider {
    static var previews: some View {
        BoardGridView(
            boxes: [
                .cross,
                .mark,
                nil,
                .cross,
                nil,
                .mark,
                .mark,
                .cross,
                nil
            ]
        ) { index in
            
        }
    }
}
