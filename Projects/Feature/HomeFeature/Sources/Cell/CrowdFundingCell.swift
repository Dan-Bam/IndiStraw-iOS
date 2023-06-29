import UIKit
import DesignSystem
import Utility
import SnapKit
import Then
import Kingfisher

class CrowdFundingCell: UITableViewCell {
    static let identifier = "CrowdFundingCell"
    
    private let fundingTitleLabel = UILabel().then {
        $0.font = DesignSystemFontFamily.Suit.bold.font(size: 16)
        $0.textColor = .white
    }
    
    private let fundingDescriptionLabel = UILabel().then {
        $0.numberOfLines = 3
        $0.textColor = DesignSystemAsset.Colors.gray.color
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 12)
    }
    
    private let fundingProgressView = UIProgressView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.progress = 0.3
        $0.progressTintColor = DesignSystemAsset.Colors.mainColor.color
        $0.trackTintColor = DesignSystemAsset.Colors.darkgray3.color
    }
    
    private let fundingPercentageLabel = UILabel().then {
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 14)
    }
    
    private let fundingImageView = UIImageView().then {
        $0.layer.cornerRadius = 3
        $0.backgroundColor = DesignSystemAsset.Colors.darkGray.color
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = DesignSystemAsset.Colors.lightBlack.color
        self.layer.cornerRadius = 10
        self.selectionStyle = .none
        
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        self.addSubviews(
            fundingTitleLabel, fundingDescriptionLabel,
            fundingImageView, fundingProgressView,
            fundingPercentageLabel
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
            $0.leading.equalTo(fundingDescriptionLabel.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(7)
            $0.size.equalTo(121)
        }
        
        fundingProgressView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(13)
            $0.bottom.equalToSuperview().inset(8)
            $0.height.equalTo(16)
        }
        
        fundingPercentageLabel.snp.makeConstraints {
            $0.trailing.equalTo(fundingImageView.snp.leading).offset(-14)
            $0.leading.equalTo(fundingProgressView.snp.trailing).offset(5)
            $0.bottom.equalTo(fundingProgressView)
        }
    }
    
    func configure(model data: FundingList) {
        fundingTitleLabel.text = data.title
        fundingDescriptionLabel.text = data.description
        fundingImageView.kf.setImage(with: URL(string: data.thumbnailUrl))
        fundingPercentageLabel.text = "\(data.percentage)%"
    }
}
