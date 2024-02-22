//
//  PostCardRequestDTO.swift
//  DOTCHI
//
//  Created by Jungbin on 2/22/24.
//

import UIKit.UIImage
import Moya

struct PostCardRequestDTO {
    let cardImage: UIImage
    let themeID: Int
    let backName: String
    let backMood: String
    let backContent: String

    enum CodingKeys: String, CodingKey {
        case cardImage = "image"
        case themeID = "themeId"
        case backName = "backName"
        case backMood = "backMood"
        case backContent = "backContent"
    }
    
    func toMultipartFormData() -> [MultipartFormData] {
        var formData: [MultipartFormData] = []
        
        formData.append(
            MultipartFormData(
                provider: .data(self.cardImage.png()),
                name: PostCardRequestDTO.CodingKeys.cardImage.rawValue,
                fileName: "image\(Date()).png",
                mimeType: "image/png"
            )
        )
        
        formData.append(
            MultipartFormData(
                provider: .data("\(self.themeID)".data(using: .utf8)!),
                name: PostCardRequestDTO.CodingKeys.themeID.rawValue
            )
        )
        
        formData.append(
            MultipartFormData(
                provider: .data(self.backName.data(using: .utf8)!),
                name: PostCardRequestDTO.CodingKeys.backName.rawValue
            )
        )
        
        formData.append(
            MultipartFormData(
                provider: .data(self.backMood.data(using: .utf8)!),
                name: PostCardRequestDTO.CodingKeys.backMood.rawValue
            )
        )
        
        formData.append(
            MultipartFormData(
                provider: .data(self.backContent.data(using: .utf8)!),
                name: PostCardRequestDTO.CodingKeys.backContent.rawValue
            )
        )
        
        return formData
    }
}
