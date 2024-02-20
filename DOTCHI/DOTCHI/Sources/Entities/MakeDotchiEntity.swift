//
//  MakeDotchiEntity.swift
//  DOTCHI
//
//  Created by Jungbin on 2/20/24.
//

import UIKit

struct MakeDotchiEntity {
    var image: UIImage
    var luckyType: LuckyType
    var dotchiName: String
    var dotchiMood: String
    var dotchiContent: String
    
    init() {
        self.image = UIImage()
        self.luckyType = .health
        self.dotchiName = ""
        self.dotchiMood = ""
        self.dotchiContent = ""
    }
}
