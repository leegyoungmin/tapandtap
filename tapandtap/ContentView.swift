//
//  ContentView.swift
//  tapandtap
//
//  Copyright (c) 2023 Minii All rights reserved.
        

import SwiftUI

struct ContentView: View {
    @State private var scale: Int = 1
    
    var body: some View {
        SelectGameView()
    }
}

#Preview {
    ContentView()
}
