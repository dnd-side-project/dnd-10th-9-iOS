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
    var cardId: Int
    
    func makeUIViewController(context: Context) -> UIViewController {
        let makeDotchiPhotoViewController = BaseUINavigationController(rootViewController: DotchiDetailViewController(cardId: self.cardId))
        
        return makeDotchiPhotoViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
