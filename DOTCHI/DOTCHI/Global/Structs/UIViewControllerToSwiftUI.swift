//
//  UIViewControllerToSwiftUI.swift
//  DOTCHI
//
//  Created by Jungbin on 2/11/24.
//

import SwiftUI
import UIKit

struct UIViewControllerToSwiftUI<T>: UIViewControllerRepresentable {
    
    let viewController: T
    
    init(_ viewController: T) {
        self.viewController = viewController
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        if let viewController = self.viewController as? UIViewController {
            return viewController
        } else {
            debugPrint(#function, type(of: self.viewController))
            return UIViewController()
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
