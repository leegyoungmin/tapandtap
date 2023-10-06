//
//  BalanceView.swift
//  tapandtap
//
//  Created by Minseong Kang on 2023/10/06.
//

import SwiftUI

enum ButtonSelectType: Int, CaseIterable {
    case none
    
    case first
    case second
    case timeOver
}

struct BalanceView: View {
    @Binding var question: Question?
    @Binding var isRestart: Bool
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var remainTime: Int = .zero
    @State private var buttonSelect: ButtonSelectType = .none
    
    let futureData: Date = Calendar.current.date(byAdding: .second, value: 16, to: Date()) ?? Date()
    
    private func updateRemainTime() {
        let remaining = Calendar.current.dateComponents([.second], from: Date(), to: futureData)
        let second = remaining.second ?? 0
        remainTime = second
    }
    
    var body: some View {
        VStack {
            Text("밸런스 게임")
                .font(.title)
                .fontWeight(.bold)
            
            Text(
                buttonSelect == .timeOver ?
                "대답을 하지 못했습니다. 맛있게 드세요~": buttonSelect == .none
                ? remainTime.description : ""
            )
            
            HStack {
                if let question = question {
                    BalanceButton(
                        selectedButtonType: $buttonSelect,
                        question: question.question1,
                        buttonSelectType: .first,
                        color: .red
                    )
                    
                    BalanceButton(
                        selectedButtonType: $buttonSelect,
                        question: question.question2,
                        buttonSelectType: .second,
                        color: .blue
                    )
                }
            }
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.white)
            
            if buttonSelect != .none || buttonSelect == .timeOver {
                Button {
                    withAnimation {
                        isRestart = true
                        question = nil
                    }
                } label: {
                    Text("돌아가기")
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .padding()
        .onReceive(timer) { _ in
            if remainTime == .zero {
                buttonSelect = .timeOver
                return
            }
            
            withAnimation {
                remainTime -= 1
            }
        }
        .onChange(of: buttonSelect, { oldValue, newValue in
            if newValue != .none {
                remainTime = .zero
            }
        })
        .onAppear {
            updateRemainTime()
        }
    }
}

struct BalanceButton: View {
    @Binding var selectedButtonType: ButtonSelectType
    let question: String
    let buttonSelectType: ButtonSelectType
    let color: Color
    
    var body: some View {
        Button {
            withAnimation {
                selectedButtonType = buttonSelectType
            }
            
        } label: {
            Text(question)
                .frame(maxWidth: 150, maxHeight: 100)
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 8)
        .background(
            selectedButtonType == .none ?
            color : selectedButtonType == buttonSelectType ? color : Color.gray.opacity(0.2)
        )
        .cornerRadius(10)
        .disabled(selectedButtonType != .none)
    }
}

#Preview {
    ZStack {
        Color.black
        
        BalanceView(question: .constant(.init(id: 1, question1: "내 직장 사람들 앞에서 방구끼고 유머있다고 칭찬 받은 애인", question2: "둘이 있는데 내 침대에서 똥 지린 애인")), isRestart: .constant(false))
    }
}
