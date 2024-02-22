//
//  BrowseViewControllerRepresentable.swift
//  DOTCHI
//
//  Created by Jungbin on 2/23/24.
//

import SwiftUI
import UIKit

struct BrowseViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        let makeDotchiPhotoViewController = BrowseViewController()
        return makeDotchiPhotoViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
