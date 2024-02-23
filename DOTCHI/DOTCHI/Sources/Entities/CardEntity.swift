//
//  CardEntity.swift
//  DOTCHI
//
//  Created by Jungbin on 2/22/24.
//

import Foundation

struct CardEntity {
    let user: CardUserEntity
    let front: CardFrontEntity
    let back: CardBackEntity
    var commentsCount: Int = APIConstants.pagingDefaultValue
}
