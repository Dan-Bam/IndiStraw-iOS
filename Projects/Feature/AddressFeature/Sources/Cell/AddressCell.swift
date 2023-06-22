import UIKit
import SnapKit
import Then
import DesignSystem
import Utility
import RxSwift
import RxCocoa

protocol autoCompleteProtocol: AnyObject {
    func autoCompleteButtonDidTap(address: String)
}

class AddressCell: UITableViewCell {
    private let disposedBag = DisposeBag()
    
    weak var delegate: autoCompleteProtocol?
    
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
        
        autoCompleteButton.rx.tap
            .bind(with: self) { owner, _ in
                let address = owner.addressLabel.text!
                owner.delegate?.autoCompleteButtonDidTap(address: address)
            }.disposed(by: disposedBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: Juso) {
        addressLabel.text = data.roadAddrPart1
        buildingNameLabel.text = data.bdNm
    }
    
    func addView() {
        self.addSubviews(
            leftMagnifyingglassImageView,
            addressLabel, autoCompleteButton
        )
        self.bringSubviewToFront(autoCompleteButton)
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
        
        autoCompleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(28)
            $0.top.bottom.equalToSuperview().inset(22)
        }
    }
}
