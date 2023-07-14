import UIKit
import SnapKit
import Then

public class CrowdFundingViewComponent: UIView {
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
        $0.progressTintColor = DesignSystemAsset.Colors.mainColor.color
        $0.trackTintColor = DesignSystemAsset.Colors.darkgray3.color
    }
    
    private let fundingPercentageLabel = UILabel().then {
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 14)
    }
    
    private let fundingImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 3
        $0.backgroundColor = DesignSystemAsset.Colors.darkGray.color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = DesignSystemAsset.Colors.lightBlack.color
        self.layer.cornerRadius = 10
        
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView() {
        self.addSubviews(
            fundingTitleLabel, fundingDescriptionLabel,
            fundingImageView, fundingProgressView,
            fundingPercentageLabel
        )
    }
    
    private func setLayout() {
        fundingImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(12)
            $0.width.equalTo(120)
        }
        
        fundingTitleLabel.snp.makeConstraints {
            $0.top.equalTo(fundingImageView)
            $0.leading.equalTo(fundingImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(11)
        }
        
        fundingDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(fundingTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(fundingTitleLabel)
            $0.trailing.equalToSuperview().inset(12)
        }
        
        fundingProgressView.snp.makeConstraints {
            $0.top.equalTo(fundingDescriptionLabel.snp.bottom).offset(38)
            $0.leading.equalTo(fundingTitleLabel)
            $0.bottom.equalToSuperview().inset(12)
            $0.height.equalTo(16)
        }
        
        fundingPercentageLabel.snp.makeConstraints {
            $0.leading.equalTo(fundingProgressView.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(12)
            $0.centerY.equalTo(fundingProgressView)
        }
    }
    
    public func configure(
        title: String,
        description: String,
        thumbnailUrl: String,
        percentage: Double
    ) {
        fundingTitleLabel.text = title
        fundingDescriptionLabel.text = description
        fundingImageView.kf.setImage(with: URL(string: thumbnailUrl))
        DispatchQueue.main.async {
            self.fundingProgressView.setProgress(0.7, animated: true)
            self.fundingProgressView.progress = Float(percentage) / 100
        }
        fundingPercentageLabel.text = (percentage == 0) ? "0%" : String(format: "%.2f", percentage) + "%"
    }
}
