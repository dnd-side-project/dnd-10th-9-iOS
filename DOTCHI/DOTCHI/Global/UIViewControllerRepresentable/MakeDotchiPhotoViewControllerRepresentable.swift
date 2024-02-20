//
//  MakeDotchiPhotoViewControllerRepresentable.swift
//  DOTCHI
//
//  Created by Jungbin on 2/17/24.
//

import SwiftUI
import UIKit

struct MakeDotchiPhotoViewControllerRepresentable: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> UIViewController {
        let makeDotchiPhotoViewController = BaseUINavigationController(rootViewController: MakeDotchiPhotoViewController())
        
        makeDotchiPhotoViewController.delegate = context.coordinator as? any UINavigationControllerDelegate
        return makeDotchiPhotoViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

protocol MakeDotchiPhotoViewControllerDelegate: AnyObject {
    func makeDotchiPhotoViewControllerDidDismiss()
}

extension MakeDotchiPhotoViewControllerRepresentable {
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, MakeDotchiPhotoViewControllerDelegate {
        
        let parent: MakeDotchiPhotoViewControllerRepresentable
        
        init(_ parent: MakeDotchiPhotoViewControllerRepresentable) {
            self.parent = parent
        }
        
        func makeDotchiPhotoViewControllerDidDismiss() {
            self.parent.isPresented = false
        }
    }
}
