import UIKit
import SnapKit
import Then

public class CategoryButton: UIButton {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        sizeToFit()
        
        layer.cornerRadius = 10
        configuration?.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5
        )
        backgroundColor = DesignSystemAsset.mainColor.color
        titleLabel?.font = DesignSystemFontFamily.Suit.medium.font(size: 14)
        setTitleColor(.white, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

