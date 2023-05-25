import UIKit
import SnapKit
import Then

public class CategoryButton: UIButton {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        backgroundColor = DesignSystemAsset.mainColor.color
        titleLabel?.font = DesignSystemFontFamily.Suit.medium.font(size: 14)
        configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        setTitleColor(.white, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

