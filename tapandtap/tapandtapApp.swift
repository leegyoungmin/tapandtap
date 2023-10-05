//
//  tapandtapApp.swift
//  tapandtap
//
//  Copyright (c) 2023 Minii All rights reserved.
        

import SwiftUI
import FirebaseCore

@main
struct tapandtapApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
