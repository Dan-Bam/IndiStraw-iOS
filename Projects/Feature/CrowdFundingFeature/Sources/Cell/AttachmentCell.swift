import UIKit
import DesignSystem
import SnapKit
import Then

class AttachmentCell: UITableViewCell {
    static let identifier = "AttachmentCell"
    
    private let linkImageView = UIImageView().then {
        $0.sizeToFit()
        $0.image = UIImage(systemName: "link")
        $0.tintColor = .white
    }
    
    private let linkUrlButton = UIButton().then {
        $0.setTitleColor(DesignSystemAsset.Colors.skyblue.color, for: .normal)
        $0.titleLabel?.font = DesignSystemFontFamily.Suit.regular.font(size: 14)
        $0.backgroundColor = .clear
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .black
        
        contentView.addSubviews(linkImageView, linkUrlButton)
        
        linkImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(14)
            $0.size.equalTo(20)
        }
        
        linkUrlButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.equalTo(linkImageView.snp.trailing)
            $0.trailing.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(linkText: String) {
        linkUrlButton.setTitle(linkText, for: .normal)
    }
}
