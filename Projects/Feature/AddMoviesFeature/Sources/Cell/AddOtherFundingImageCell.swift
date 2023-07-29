import UIKit
import SnapKit
import Then
import DesignSystem

class AddOtherFundingImageCell: UICollectionViewCell {
    static let identifier = "AddOtherFundingImageCell"
    
    private let otherImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.backgroundColor = DesignSystemAsset.Colors.darkgray3.color
    }
    
    private let ImageRemoveButton = UIButton().then {
        $0.clipsToBounds = true
        $0.backgroundColor = DesignSystemAsset.Colors.lightBlack.color
        $0.layer.cornerRadius = 10
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubviews(
            otherImageView, ImageRemoveButton
        )
        
        otherImageView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(4)
            $0.leading.bottom.equalToSuperview()
        }
        
        ImageRemoveButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.size.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage) {
        otherImageView.image = image
    }
}
