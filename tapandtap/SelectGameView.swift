//
//  GameView.swift
//  tapandtap
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct SelectGameView: View {
    @State private var userCount: Int = 2
    @State private var isStart: Bool = false
    @State private var targetNumber: Int = .zero
    @State private var touchIndex: [Int] = []
    @State private var isSelectTarget: Bool = false
    
    var body: some View {
        VStack {
            // Game Control Section
            GameUserControl(userCount: $userCount)
                .padding(.horizontal, 16)
                .disabled(isStart)
            
            Spacer()
            
            // Game Board Section
            GameBoardView(
                userCount: $userCount,
                targetNumber: $targetNumber,
                isSelectTarget: $isSelectTarget,
                isStart: $isStart
            )
            
            Spacer()
            
            // Game Start Section
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
                .background(Color.white)
                .cornerRadius(100)
                .padding()
            }
        }
        .background(.black)
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

struct GameBoardView: View {
    @Binding var userCount: Int
    @Binding var targetNumber: Int
    @Binding var isSelectTarget: Bool
    @Binding var isStart: Bool
    
    @State private var touchIndexes: [Int] = []
    
    private let columns: [GridItem] = Array(repeating: .init(), count: 3)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 32) {
            ForEach(1...userCount, id: \.self) { index in
                Button {
                    touchIndexes.append(index)
                    withAnimation {
                        isSelectTarget = index == targetNumber
                    }
                } label: {
                    Image(
                        isSelectTarget && index == targetNumber ?
                        "card_beer" : touchIndexes.contains(index) ? "" : "card_back"
                    )
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 110, maxHeight: 150)
                }
            }
        }
        .disabled(
            isStart == false || isSelectTarget == true
        )
    }
}

#Preview {
    SelectGameView()
}
