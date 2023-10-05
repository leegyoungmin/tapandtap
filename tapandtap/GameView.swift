//
//  GameView.swift
//  tapandtap
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct GameView: View {
    @State private var userCount: Int = 2
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            GameUserControl(userCount: $userCount)
                .padding(.horizontal, 16)
            
            LazyVGrid(
                columns: Array(
                    repeating: .init(),
                    count: 3
                )
            ) {
                ForEach(0..<userCount, id: \.self) { _ in
                    
                }
            }
        }
    }
}

struct GameUserControl: View {
    @Binding var userCount: Int
    
    @ViewBuilder
    func userControlButton(isUp: Bool) -> some View {
        Button {
            withAnimation {
                if isUp {
                    if userCount == 9 { return }
                    userCount += 1
                } else {
                    if userCount == 2 { return }
                    userCount -= 1
                }
            }
        } label: {
            Image(
                systemName: isUp ? "chevron.right" : "chevron.left"
            )
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                userControlButton(isUp: false)
                
                Spacer()
                
                Text("\(userCount)")
                    .frame(width: 50)
                
                Spacer()
                
                userControlButton(isUp: true)
            }
            .font(.system(size: 18))
            .padding()
            .background(.white)
            .cornerRadius(400)
            
            Spacer()
        }
    }
}

#Preview {
    GameView()
}
