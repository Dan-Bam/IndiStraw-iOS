import UIKit

public class ErrorLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textColor = DesignSystemAsset.Colors.red.color
        font = DesignSystemFontFamily.Suit.regular.font(size: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
