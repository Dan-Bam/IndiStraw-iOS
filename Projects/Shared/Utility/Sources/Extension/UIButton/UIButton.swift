import UIKit
import DesignSystem

public extension UIButton {
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttributes([
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: DesignSystemAsset.Colors.exampleText.color,
        ], range: NSRange(location: 0, length: title.count))
        
        setAttributedTitle(attributedString, for: .normal)
    }
}
