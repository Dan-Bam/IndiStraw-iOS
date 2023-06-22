import UIKit
import BaseFeature
import SnapKit
import Then
import DesignSystem

class DetailAddressViewController: BaseVC<DetailAddressViewModel> {
    private let nowAddressLabel = UILabel().then {
        $0.text = "현재주소"
        $0.font = DesignSystemFontFamily.Suit.bold.font(size: 24)
        $0.textColor = .white
    }
    
    private let zipCodeLabel = UILabel().then {
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 14)
        $0.textColor = .white
    }
    
    private let roadAddrPartLabel = UILabel().then {
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 14)
        $0.textColor = .white
    }
    
    init(viewModel: DetailAddressViewModel, zipCode: String, roadAddrPart: String) {
        super.init(viewModel: viewModel)
        zipCodeLabel.text = zipCode
        roadAddrPartLabel.text = roadAddrPart
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureVC() {
    }
    
    override func addView() {
        view.addSubviews(nowAddressLabel, zipCodeLabel, roadAddrPartLabel)
    }
    
    override func setLayout() {
        nowAddressLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(44)
            $0.leading.equalToSuperview().inset(32)
        }
        
        zipCodeLabel.snp.makeConstraints {
            $0.top.equalTo(nowAddressLabel.snp.bottom).inset(16)
            $0.leading.equalTo(nowAddressLabel)
        }
        
        roadAddrPartLabel.snp.makeConstraints {
            $0.top.equalTo(zipCodeLabel.snp.bottom).offset(2)
            $0.leading.equalTo(nowAddressLabel)
        }
    }
}
