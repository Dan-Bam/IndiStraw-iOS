import UIKit
import DesignSystem
import SnapKit
import Then

class AttachmentCell: UITableViewCell {
    static let identifier = "AttachmentCell"
    
    private let linkImageView = UIImageView().then {
        $0.image = UIImage(systemName: "link")?.withTintColor(.white)
    }
    
    private let linkeUrlButton = UIButton().then {
        $0.setTitleColor(DesignSystemAsset.Colors.skyblue.color, for: .normal)
        $0.backgroundColor = .clear
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        linkImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.equalToSuperview().inset(14)
            $0.size.equalTo(20)
        }
        
        linkeUrlButton.snp.makeConstraints {
            $0.centerX.equalTo(linkImageView)
            $0.leading.equalTo(linkImageView.snp.trailing).offset(8)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(linkText: String) {
        linkeUrlButton.setTitle(linkText, for: .normal)
    }
}
