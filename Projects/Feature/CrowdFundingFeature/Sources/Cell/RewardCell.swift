import UIKit
import DesignSystem
import SnapKit
import Then
import Kingfisher

class RewardCell: UITableViewCell {
    static let identifier = "RewardCell"
    
    private let rewardImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 3
    }
    
    private let rewardTitleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.semiBold.font(size: 16)
    }
    
    private let rewardDescriptionLabel = UILabel().then {
//        $0.numberOfLines = 2q
        $0.textColor = DesignSystemAsset.Colors.gray.color
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 14)
    }
    
    private let rewardPriceLabel = UILabel().then {
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.semiBold.font(size: 14)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = DesignSystemAsset.Colors.darkgray3.color
        self.backgroundColor = .black
        selectionStyle = .none
        
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
            rewardImageView, rewardTitleLabel,
            rewardDescriptionLabel, rewardPriceLabel
        )
    }
    
    private func setLayout() {
        rewardImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(8)
            $0.width.equalTo(100)
        }
        
        rewardTitleLabel.snp.makeConstraints {
            $0.top.equalTo(rewardImageView.snp.top)
            $0.leading.equalTo(rewardImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(11)
        }
        
        rewardDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(rewardTitleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(rewardTitleLabel)
            $0.trailing.equalToSuperview().inset(14)
        }
        
        rewardPriceLabel.snp.makeConstraints {
            $0.top.equalTo(rewardDescriptionLabel.snp.bottom).offset(12)
            $0.leading.equalTo(rewardTitleLabel)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}

extension RewardCell {
    func configure(model: Reward) {
        rewardImageView.kf.setImage(with: URL(string: model.imageUrl))
        rewardTitleLabel.text = model.title
        rewardDescriptionLabel.text = model.description
        rewardPriceLabel.text = "\(model.price)" + "원"
    }
}
