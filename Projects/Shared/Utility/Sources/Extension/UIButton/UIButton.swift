import UIKit
import DesignSystem

public extension UIButton {
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttributes([
            .underlineColor: NSUnderlineStyle.single.rawValue,
            .foregroundColor: DesignSystemAsset.Colors.exampleText.color
        ], range: NSRange(location: 0, length: title.count))
        
        setAttributedTitle(attributedString, for: .normal)
    }
}
