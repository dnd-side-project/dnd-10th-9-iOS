//
//  ImageCacheManager.swift
//  DOTCHI
//
//  Created by Jungbin on 2/5/24.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
