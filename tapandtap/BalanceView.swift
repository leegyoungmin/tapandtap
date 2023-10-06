//
//  BalanceView.swift
//  tapandtap
//
//  Created by Minseong Kang on 2023/10/06.
//

import SwiftUI

struct BalanceView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            HStack {
                VStack(content: {
                    Text("밸런스 게임")
                        .font(.title)
                    Text("30초 내에 선택하세요~")
                        .font(.footnote)
                        .padding(.top, 10)
                    Text("선택하지 못하면 벌주입니다.")
                        .font(.footnote)
                        .lineSpacing(20)
                    VStack(content: {
                        HStack(content: {
                            Button(action: {
                                print("A 버튼")
                            }, label: {
                                Text("A\n매일 매일 만나기")
                                    .padding(.horizontal, 10)
                                    .frame(width: 100, height: 100)
                                    .foregroundStyle(.white)
                                    .background(.red)
                            })
                            Button(action: {
                                print("B 버튼")
                            }, label: {
                                Text("B\n한달에 한번 만나기")
                                    .padding(.horizontal, 10)
                                    .frame(width: 100, height: 100)
                                    .foregroundStyle(.white)
                                    .background(.blue)
                            })
                        })
                        .padding(.top, 20)
                    })
                    
                })
                .frame(width: 300, height: 250, alignment: .center)
                .background(.white)
            }
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 7)
                    .stroke(.clear, lineWidth: 1)
            }
            .padding([.top, .horizontal])
        }
        
        
        
    }
}

#Preview {
    BalanceView()
}
