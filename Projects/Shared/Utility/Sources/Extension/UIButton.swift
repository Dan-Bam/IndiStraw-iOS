import UIKit

public extension UIButton {
    func setUnderline(color: UIColor) {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttributes([
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: color,
        ], range: NSRange(location: 0, length: title.count))
        
        setAttributedTitle(attributedString, for: .normal)
    }
}
