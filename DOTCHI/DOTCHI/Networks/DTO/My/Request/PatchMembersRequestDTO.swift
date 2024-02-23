//
//  PatchMembersRequestDTO.swift
//  DOTCHI
//
//  Created by yubin on 2/23/24.
//

import UIKit.UIImage
import Moya

struct PatchMembersRequestDTO {
    let memberImage: UIImage
    let memberName: String
    let memberDescription: String

    enum CodingKeys: String, CodingKey {
        case memberImage = "memberImage"
        case memberName = "memberName"
        case memberDescription = "memberDescription"
    }
    
    func toMultipartFormData() -> [MultipartFormData] {
        var formData: [MultipartFormData] = []
        
        formData.append(
            MultipartFormData(
                provider: .data(self.memberImage.png()),
                name: PatchMembersRequestDTO.CodingKeys.memberImage.rawValue,
                fileName: "34f2743d-a9\(index).png",
                mimeType: "image/png"
            )
        )
        
        formData.append(
            MultipartFormData(
                provider: .data("\(self.memberName)".data(using: .utf8)!),
                name: PatchMembersRequestDTO.CodingKeys.memberName.rawValue
            )
        )
        
        formData.append(
            MultipartFormData(
                provider: .data(self.memberDescription.data(using: .utf8)!),
                name: PatchMembersRequestDTO.CodingKeys.memberDescription.rawValue
            )
        )
        
        return formData
    }
}

