import UIKit
import BaseFeature
import SnapKit
import Then
import DesignSystem

class DetailAddressViewController: BaseVC<DetailAddressViewModel> {
    private let zipCodeLabel = UILabel().then {
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 14)
        $0.textColor = .white
    }
    
    private let addressLabel = UILabel().then {
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 14)
        $0.textColor = .white
    }
    
    override func configureVC() {
        navigationItem.title = "현재 주소"
    }
    
    override func addView() {
        view.addSubviews(zipCodeLabel, addressLabel)
    }
    
    override func setLayout() {
        zipCodeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.equalToSuperview().inset(32)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(zipCodeLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().inset(32)
        }
    }
}
