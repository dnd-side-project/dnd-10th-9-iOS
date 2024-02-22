//
//  DOTCHIApp.swift
//  DOTCHI
//
//  Created by Jungbin on 2/5/24.
//

import SwiftUI

@main
struct DOTCHIApp: App {
    
    @State private var isSignInViewPresented = true
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            SignInViewControllerRepresentable(isPresented: $isSignInViewPresented)
                .ignoresSafeArea()
        }
    }
}
