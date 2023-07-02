import UIKit
import BaseFeature
import SnapKit
import Then
import DesignSystem

class CrowdFundingViewController: BaseVC<CrowdFundingViewModel> {
    private let fundingImageView = UIImageView()
    
    private let mcLabel = UILabel().then {
        $0.textColor = DesignSystemAsset.Colors.lightGray.color
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 12)
    }
    
    private let fundingTitleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 18)
    }
    
    override func addView() {
        view.addSubviews(
            fundingImageView, mcLabel,
            fundingTitleLabel
        )
    }
    
    override func setLayout() {
        fundingImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(17)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(170)
        }
    }
}
