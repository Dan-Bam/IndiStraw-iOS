import Foundation
import UIKit

public extension String {
    func getStringToDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = .current
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        return formatter.date(from: self)!
    }
    
    func attributedString(font: UIFont) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttributes([.font: font], range: (self as NSString).range(of: self))
        
        return attributeString
    }
}
