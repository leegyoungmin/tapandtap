//
//  BalanceView.swift
//  tapandtap
//
//  Created by Minseong Kang on 2023/10/06.
//

import SwiftUI

struct BalanceView: View {
    @Binding var question: Question?
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var remainTime: Int = .zero
    
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
            
            // Timer 구현하기
            Text(remainTime.description)
            
            HStack {
                Button {
                    
                } label: {
                    Text("매일 매일 만나기")
                        .frame(maxWidth: 150, maxHeight: 100)
                }
                .background(.red)
                .cornerRadius(10)
                
                Button {
                    
                } label: {
                    Text("한달에 한번 만나기")
                        .frame(maxWidth: 150, maxHeight: 100)
                }
                .background(.blue)
                .cornerRadius(10)
            }
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.white)
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .padding()
        .onReceive(timer) { _ in
            if remainTime == .zero {
                return
            }
            
            withAnimation {
                remainTime -= 1
            }
        }
        .onAppear {
            updateRemainTime()
        }
    }
}
