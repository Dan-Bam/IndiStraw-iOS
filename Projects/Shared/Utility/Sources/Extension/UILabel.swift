import UIKit

public extension UILabel {
    func customAttributedString(text: String, font: UIFont) {
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttributes([.font: font], range: (text as NSString).range(of: text))
    }
}
