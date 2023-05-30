import UIKit

public class CategoryButton: UIButton {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        configuration?.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 3,
            bottom: 5,
            trailing: 3
        )
        backgroundColor = DesignSystemAsset.Colors.mainColor.color
        titleLabel?.font = DesignSystemFontFamily.Suit.medium.font(size: 14)
        setTitleColor(.white, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

