import UIKit
import BaseFeature
import SnapKit
import Then
import DesignSystem

class CrowdFundingViewController: BaseVC<CrowdFundingViewModel> {
    private let fundingImageView = UIImageView().then {
        $0.backgroundColor = .gray
    }
    
    private let mcLabel = UILabel().then {
        $0.text = "진행자: 김성길"
        $0.textColor = DesignSystemAsset.Colors.lightGray.color
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 12)
    }
    
    private let fundingTitleLabel = UILabel().then {
        $0.text = "그립톡으로 유기동물 보호하기"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 18)
        $0.numberOfLines = 0
    }
    
    override func configureVC() {
        viewModel.requestCrowdFundingList()
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
        
        mcLabel.snp.makeConstraints {
            $0.top.equalTo(fundingImageView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(15)
        }
        
        fundingTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mcLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
    }
}
