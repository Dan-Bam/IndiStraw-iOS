import UIKit
import DesignSystem
import SnapKit
import Then
import Kingfisher

class CrowdFundingCell: UITableViewCell {
    static let identifier = "CrowdFundingCell"
    
    private let component = CrowdFundingViewComponent()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 10
        self.backgroundColor = .black
        self.selectionStyle = .none
        
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(
            top: 0, left: 15, bottom: 16, right: 15)
        )
    }
    
    private func addView() {
        contentView.addSubviews(
            component
        )
    }
    
    private func setLayout() {
        component.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(model data: FundingList) {
        component.configure(
            title: data.title,
            description: data.description,
            thumbnailUrl: data.thumbnailUrl,
            percentage: data.percentage
        )
    }
}

