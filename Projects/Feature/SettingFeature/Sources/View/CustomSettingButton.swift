import UIKit
import BaseFeature
import SnapKit
import Then
import DesignSystem

class CustomSettingButton: UIButton {
    var type: String?
    
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
    
    func configure(type: String) {
        textLabel.text = type
        self.type = type
        
        switch type {
        case customButonType.editProfile:
            logoImageView.image = UIImage(systemName: "person")
        case customButonType.editPassword:
            logoImageView.image = UIImage(systemName: "shield")
        case customButonType.editLanguage:
            logoImageView.image = UIImage(systemName: "network")
        default:
            textLabel.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().inset(13)
            }
        }
    }
}
