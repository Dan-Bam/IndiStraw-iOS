import UIKit
import SnapKit
import Then
import DesignSystem
import Utility
import RxSwift
import RxCocoa

class AddressCell: UITableViewCell {
    private let disposedBag = DisposeBag()

    static let identifier = "AddressCell"
    
    private let leftMagnifyingglassImageView = UIImageView().then {
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.tintColor = .white
    }
    
    private let addressLabel = UILabel().then {
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 16)
        $0.textColor = .white
    }
    
    private let buildingNameLabel = UILabel().then {
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 14)
        $0.textColor = .gray
    }
    
    private let autoCompleteButton = UIButton().then {
        $0.setImage(UIImage(systemName: "arrow.up.left"), for: .normal)
        $0.tintColor = .white
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .black
        self.selectionStyle = .none
        
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: Juso) {
        addressLabel.text = data.roadAddrPart1
        buildingNameLabel.text = data.bdNm
    }
    
    private func addView() {
        self.addSubviews(
            leftMagnifyingglassImageView, addressLabel,
            buildingNameLabel, autoCompleteButton
        )
        self.bringSubviewToFront(autoCompleteButton)
    }
    
    private func setLayout() {
        leftMagnifyingglassImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(25)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(22)
            $0.leading.equalTo(leftMagnifyingglassImageView.snp.trailing).offset(14)
        }
        
        buildingNameLabel.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(7)
            $0.leading.equalTo(addressLabel.snp.leading)
        }
        
        autoCompleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(28)
            $0.top.bottom.equalToSuperview().inset(22)
        }
    }
}
