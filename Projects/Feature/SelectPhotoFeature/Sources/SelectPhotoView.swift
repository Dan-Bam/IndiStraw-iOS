import UIKit
import DesignSystem
import Utility
import RxSwift
import RxCocoa

public protocol presentBottomSheetProtocol: AnyObject {
    func presentBottomSheet()
}

public class SelectPhotoViewButton: UIButton {
    weak public var delegate: presentBottomSheetProtocol?
    
    private let disposeBag = DisposeBag()
    
    public let photoImageButton = UIButton().then {
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = false
        $0.isEnabled = true
        $0.backgroundColor = DesignSystemAsset.Colors.gray.color
        $0.setImage(DesignSystemAsset.Images.inputPhoto.image, for: .normal)
        $0.layer.cornerRadius = 62.5
    }
    
    private let plusImageButton = UIButton().then {
        $0.isUserInteractionEnabled = false
        $0.setTitle("+", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 20
        $0.backgroundColor = DesignSystemAsset.Colors.blue.color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews(photoImageButton, plusImageButton)
        
        photoImageButton.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.size.equalTo(125)
        }
        
        plusImageButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        self.rx.tap
            .bind(with: self) { owner, _ in
                owner.delegate?.presentBottomSheet()
            }.disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
