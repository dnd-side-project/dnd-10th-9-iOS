//
//  DotchiDetailViewControllerRepresentable.swift
//  DOTCHI
//
//  Created by Jungbin on 2/21/24.
//

import SwiftUI
import UIKit

struct DotchiDetailViewControllerRepresentable: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> UIViewController {
        let makeDotchiPhotoViewController = BaseUINavigationController(rootViewController: DotchiDetailViewController())
        
        return makeDotchiPhotoViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
