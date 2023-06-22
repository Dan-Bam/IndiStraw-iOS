import UIKit
import SnapKit
import Then
import DesignSystem
import Utility

class AddressCell: UITableViewCell {
    
    private let leftMagnifyingglassImageView = UIImageView().then {
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.tintColor = .white
    }
    
    private let addressLabel = UILabel().then {
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 16)
        $0.textColor = .white
    }
    
    private let rightArrowImageView = UIImageView().then {
        $0.image = UIImage(systemName: "arrow.up.left")
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        self.addSubviews(
            leftMagnifyingglassImageView,
            addressLabel, rightArrowImageView
        )
    }
    
    func setLayout() {
        leftMagnifyingglassImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(25)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(22)
            $0.leading.equalTo(leftMagnifyingglassImageView.snp.trailing).offset(14)
        }
        
        rightArrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(28)
            $0.top.bottom.equalToSuperview().inset(22)
        }
    }
}
