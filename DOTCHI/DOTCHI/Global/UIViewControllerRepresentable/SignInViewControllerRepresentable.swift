//
//  SignInViewControllerRepresentable.swift
//  DOTCHI
//
//  Created by Jungbin on 2/22/24.
//

import SwiftUI
import UIKit

struct SignInViewControllerRepresentable: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = SignInViewController()
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
