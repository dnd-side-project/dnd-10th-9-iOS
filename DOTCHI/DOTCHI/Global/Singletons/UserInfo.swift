//
//  UserInfo.swift
//  DOTCHI
//
//  Created by Jungbin on 2/5/24.
//

import Foundation

final class UserInfo {
    static var shared = UserInfo()
    
    init() { }
    
    var userID: Int = -1
    var accessToken: String = ""
    var refreshToken: String = ""
    var deviceToken: String = ""
    var username: String = ""
    var profileImageUrl: String = ""
}
