//
//  GameView.swift
//  tapandtap
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct GameView: View {
    @State private var userCount: Int = 2
    @State private var isStart: Bool = false
    @State private var targetNumber: Int = .zero
    @State private var touchIndex: [Int] = []
    @State private var isSelectTarget: Bool = false
    
    var body: some View {
        VStack {
            GameUserControl(userCount: $userCount)
                .padding(.horizontal, 16)
                .disabled(isStart)
            
            Spacer()
            
            LazyVGrid(
                columns: Array(
                    repeating: .init(),
                    count: 3
                )
            ) {
                ForEach(1...userCount, id: \.self) { index in
                    Button {
                        touchIndex.append(index)
                        withAnimation {
                            isSelectTarget = index == targetNumber
                        }
                    } label: {
                        Image(
                            isSelectTarget && index == targetNumber ?
                            "card_beer" : touchIndex.contains(index) ? "" : "card_back"
                        )
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 110, maxHeight: 150)
                    }
                }
            }
            .disabled(!isStart)
            
            Spacer()
            
            if isStart == false {
                Button {
                    withAnimation {
                        isStart = true
                    }
                } label: {
                    Text("게임 시작")
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .background(Color.black)
                .cornerRadius(100)
                .padding()
            }
        }
        .onChange(of: isStart) { _, newValue in
            if newValue == false { return }
            
            guard let randomNumber = (1...userCount).randomElement() else { return }
            self.targetNumber = randomNumber
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
        
    }
}

#Preview {
    GameView()
}
