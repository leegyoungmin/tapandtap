//
//  BalanceView.swift
//  tapandtap
//
//  Created by Minseong Kang on 2023/10/06.
//

import SwiftUI

struct BalanceView: View {
    @Binding var question: Question?
    
    var body: some View {
        VStack {
            Text("밸런스 게임")
                .font(.title)
                .fontWeight(.bold)
            
            // Timer 구현하기
            
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
    }
}
