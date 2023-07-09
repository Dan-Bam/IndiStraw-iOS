import UIKit
import DesignSystem
import Utility

class CastCell: UICollectionViewCell {
    static let identifier = "CastCell"
    
    private let castImageView = UIImageView().then {
        $0.layer.cornerRadius = 22.5
    }
    
    private let castNameLabel = UILabel().then {
        $0.font = DesignSystemFontFamily.Suit.semiBold.font(size: 14)
    }
    
    private let roleLabel = UILabel().then {
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 12)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        self.addSubviews(
            castImageView, castNameLabel,
            roleLabel
        )
    }
    
    func setLayout() {
        castImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(55)
        }
        
        castNameLabel.snp.makeConstraints {
            $0.top.equalTo(castImageView.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        roleLabel.snp.makeConstraints {
            $0.top.equalTo(castNameLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
    }
}
