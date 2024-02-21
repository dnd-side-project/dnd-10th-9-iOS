//
//  String+.swift
//  DOTCHI
//
//  Created by Jungbin on 2/20/24.
//

import Foundation
import UIKit.UIImage

extension String {
    func getImage(completion: @escaping (UIImage) -> ()){
        let cacheKey = NSString(string: self)
        
        /// 해당 Key에 캐시 이미지가 저장되어 있으면 이미지 사용
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            completion(cachedImage)
        }
        
        if let requestURL = URL(string: self) {
            let request = URLRequest(url: requestURL)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data,
                   let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300,
                   let image = UIImage(data: data) {
                    
                    /// 다운받은 이미지를 캐시에 저장
                    ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                    completion(image)
                }
            }.resume()
        }
    }
    
    func size(OfFont font: UIFont) -> CGSize {
        let size = (self as NSString).size(withAttributes: [.font: font])
        let buffer = 0.2 // 이게 없으면 UILabel이 잘려보이는 현상이 존재
        return CGSize(width: size.width + buffer, height: size.height)
    }
    
    mutating func removeLastSpace() {
        self = self.replacingOccurrences(of: "^\\s+", with: "", options: .regularExpression)
    }
    
    func removedLastSpace() -> String {
        return self.replacingOccurrences(of: "^\\s+", with: "", options: .regularExpression)
    }
    
    func verifyUrl() -> Bool {
        let types: NSTextCheckingResult.CheckingType = [.link]
        let detector = try? NSDataDetector(types: types.rawValue)
        guard (detector != nil && self.count > 0) else { return false }
        if detector!.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) > 0 {
            return true
        }
        return false
    }
    
    func indexing(_ index: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: index)])
    }
    
    /// 특정 문자열이 두 번 들어가 있는지 검사하는 메서드
    func isSubstringRepeatedTwice(_ substring: String) -> Bool {
        guard self.range(of: substring) != nil else {
            return false // 문자열에 해당 부분 문자열이 없으면 false 반환
        }
        
        // 문자열을 두 번 이상 포함하는지 확인
        var remainingString = self
        if let range = remainingString.range(of: substring) {
            remainingString.removeSubrange(range)
            if remainingString.range(of: substring) != nil {
                return true // 두 번 이상 포함하는 부분 문자열이 있으면 true 반환
            }
        }
        
        return false
    }
}
