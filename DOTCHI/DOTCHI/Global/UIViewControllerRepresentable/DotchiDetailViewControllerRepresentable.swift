//
//  DotchiDetailViewControllerRepresentable.swift
//  DOTCHI
//
//  Created by Jungbin on 2/21/24.
//

import SwiftUI
import UIKit

struct DotchiDetailViewControllerRepresentable: UIViewControllerRepresentable {
    var cardId: Int
    
    func makeUIViewController(context: Context) -> DotchiDetailViewController {
            return DotchiDetailViewController(cardId: cardId)
    }

    func updateUIViewController(_ uiViewController: DotchiDetailViewController, context: Context) {
        
    }
}
