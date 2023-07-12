import UIKit
import DesignSystem
import SnapKit
import Then
import Kingfisher
import Utility

class RewardCell: UITableViewCell {
    static let identifier = "RewardCell"
    
    private let remainingDay = BasePaddingButton(padding: UIEdgeInsets(
        top: 1, left: 5, bottom: 1, right: 5)
    ).then {
        $0.clipsToBounds = true
        $0.titleLabel?.font = DesignSystemFontFamily.Suit.regular.font(size: 12)
        $0.backgroundColor = DesignSystemAsset.Colors.mainColor.color
        $0.setTitleColor(DesignSystemAsset.Colors.purple2.color, for: .normal)
        $0.layer.cornerRadius = 5
    }
    
    private let rewardTitleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.semiBold.font(size: 16)
    }
    
    private let rewardDescriptionLabel = UILabel().then {
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
            remainingDay, rewardTitleLabel,
            rewardDescriptionLabel, rewardPriceLabel
        )
    }
    
    private func setLayout() {
        rewardTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        
        rewardDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(rewardTitleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        
        rewardPriceLabel.snp.makeConstraints {
            $0.top.equalTo(rewardDescriptionLabel.snp.bottom).offset(25)
            $0.leading.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(18)
        }
        
        remainingDay.snp.makeConstraints {
            $0.top.equalTo(rewardDescriptionLabel.snp.bottom).offset(25)
            $0.leading.equalTo(rewardPriceLabel.snp.trailing).offset(8)
            $0.bottom.equalToSuperview().inset(18)
        }
    }
}

extension RewardCell {
    func configure(model: Reward) {
        rewardTitleLabel.text = model.title
        rewardDescriptionLabel.text = model.description
        rewardPriceLabel.text = "\(model.price.setMoneyType())원"
        remainingDay.setTitle("\(model.totalCount)" + "개 남음", for: .normal)
    }
}
