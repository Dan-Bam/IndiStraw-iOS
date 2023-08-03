import UIKit
import SnapKit
import Then
import DesignSystem
import RxSwift
import RxCocoa
import Utility

protocol RemoveCollectionViewCellHandlerProtocol: AnyObject {
    func removeImageButtonDidTap(index: Int)
}

class AddOtherFundingImageCell: UICollectionViewCell {
    static let identifier = "AddOtherFundingImageCell"
    
    private var index = 0
    
    private let disposeBag = DisposeBag()
    
    weak var delegate: RemoveCollectionViewCellHandlerProtocol?
    
    private let otherImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.backgroundColor = DesignSystemAsset.Colors.darkgray3.color
    }
    
    private let ImageRemoveButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark")?
            .resized(to: CGSize(width: 11, height: 11))?
            .withTintColor(.white), for: .normal)
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
        
        ImageRemoveButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.delegate?.removeImageButtonDidTap(index: owner.index)
            }.disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage) {
        otherImageView.image = image
    }
    
    func setRowIdx(row index: Int) {
        self.index = index
    }
}
