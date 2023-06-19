import UIKit
import BaseFeature
import SnapKit
import Then
import DesignSystem

class CustomSettingButton: UIButton {
    private let logoImageView = UIImageView().then {
        $0.tintColor = .white
    }
    
    private let textLabel = UILabel().then {
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.backgroundColor = DesignSystemAsset.Colors.lightBlack.color
        
        self.addSubviews(logoImageView, textLabel)
        
        logoImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(15)
            $0.size.equalTo(24)
        }
        
        textLabel.snp.makeConstraints {
            $0.centerY.equalTo(logoImageView)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func setImage() {
//        logoImageView.snp.makeConstraints {
//            $0.top.leading.bottom.equalToSuperview().inset(16)
//            $0.size.equalTo(25)
//        }
//    }
    
    func setText(text: String) {
        textLabel.text = text
    }
}
