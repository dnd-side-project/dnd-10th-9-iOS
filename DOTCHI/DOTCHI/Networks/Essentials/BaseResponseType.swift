//
//  BaseResponseType.swift
//  DOTCHI
//
//  Created by Jungbin on 2/5/24.
//

import Foundation

struct BaseResponseType<T: Decodable>: Decodable {
    
    var code: Int
    var message: String
    var result: T?
    
    enum CodingKeys: String, CodingKey {
        case status = "code"
        case message = "message"
        case result = "result"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = (try? values.decode(Int.self, forKey: .status)) ?? -1
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        result = (try? values.decode(T.self, forKey: .result)) ?? nil
    }
}
