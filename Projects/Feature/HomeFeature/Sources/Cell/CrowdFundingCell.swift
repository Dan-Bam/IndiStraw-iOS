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
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 3
        $0.backgroundColor = DesignSystemAsset.Colors.darkGray.color
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = DesignSystemAsset.Colors.lightBlack.color
        self.backgroundColor = .black
        contentView.layer.cornerRadius = 10
        self.selectionStyle = .none
        
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 16, right: 15))
        
    }
    
    private func addView() {
        contentView.addSubviews(
            fundingTitleLabel, fundingDescriptionLabel,
            fundingImageView, fundingProgressView,
            fundingPercentageLabel
        )
    }
    
    private func setLayout() {
        fundingTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(13)
        }

        fundingDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(fundingTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(fundingTitleLabel)
        }

        fundingImageView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview().inset(8)
            $0.leading.equalTo(fundingDescriptionLabel.snp.trailing).offset(-5)
            $0.width.equalTo(120)
        }

        fundingProgressView.snp.makeConstraints {
            $0.top.equalTo(fundingDescriptionLabel.snp.bottom).offset(22)
            $0.leading.equalTo(fundingTitleLabel)
            $0.bottom.equalToSuperview().inset(8)
            $0.height.equalTo(16)
        }

        fundingPercentageLabel.snp.makeConstraints {
            $0.leading.equalTo(fundingProgressView.snp.trailing).offset(5)
            $0.trailing.equalTo(fundingImageView.snp.leading).offset(-14)
            $0.centerY.equalTo(fundingProgressView)
        }
    }
    
    func configure(model data: FundingList) {
        fundingTitleLabel.text = data.title
        fundingDescriptionLabel.text = data.description
        fundingImageView.kf.setImage(with: URL(string: data.thumbnailUrl))
//        UIView.animate(
//            withDuration: 0.5,
//            animations: {
//            }
//        )
        fundingProgressView.setProgress(0.7, animated: true)
        self.fundingProgressView.progress = Float(data.percentage) / 100
        fundingPercentageLabel.text = "\(data.percentage)%"
    }
}
