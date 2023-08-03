import UIKit

public extension String {
    func attributedString(font: UIFont) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttributes([.font: font], range: (self as NSString).range(of: self))
        
        return attributeString
    }
}
