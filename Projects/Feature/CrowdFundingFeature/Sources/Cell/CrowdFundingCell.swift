import UIKit
import DesignSystem
import Utility
import SnapKit
import Then

class CrowdFundingCell: UITableViewCell {
    static let identifier = "CrowdFundingCell"
    
    private let fundingTitleLabel = UILabel().then {
        $0.font = DesignSystemFontFamily.Suit.bold.font(size: 16)
        $0.textColor = .white
    }
    
    private let fundingDescriptionLabel = UILabel().then {
        $0.textColor = DesignSystemAsset.Colors.gray.color
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 12)
    }
    
    private let fundingImageView = UIImageView().then {
        $0.layer.cornerRadius = 3
        $0.backgroundColor = DesignSystemAsset.Colors.darkGray.color
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = DesignSystemAsset.Colors.lightBlack.color
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        self.addSubviews(
            fundingTitleLabel, fundingDescriptionLabel,
            fundingImageView
        )
    }
    
    func setLayout() {
        fundingTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(13)
        }
        
        fundingDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(fundingTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(fundingTitleLabel)
        }
        
        fundingImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(7)
        }
    }
}
