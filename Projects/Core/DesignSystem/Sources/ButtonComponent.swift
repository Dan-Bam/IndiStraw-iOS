import UIKit

public class ButtonComponent: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("asdf")
        
        self.layer.cornerRadius = 10
        self.backgroundColor = DesignSystemAsset.mainColor.color
        self.titleLabel?.textColor = .white
        self.titleLabel?.font = DesignSystemFontFamily.Suit.medium.font(size: 18)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
