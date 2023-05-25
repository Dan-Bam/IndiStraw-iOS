import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

public class TextFieldBox: UITextField {
    private var iconTaped = false
    
    private let disposeBag = DisposeBag()
    
    private let eyeIconButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye"), for: .normal)
        $0.tintColor = DesignSystemAsset.exampleText.color
        $0.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        backgroundColor = DesignSystemAsset.textBox.color
        font = DesignSystemFontFamily.Suit.medium.font(size: 14)
        textColor = DesignSystemAsset.exampleText.color
        addView()
        setLayout()
        self.isSecureTextEntry = true
        
        eyeIconButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.iconTaped.toggle()
                owner.isSecureTextEntry =  owner.iconTaped ? false : true
            }.disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView() {
        addSubview(eyeIconButton)
    }
    
    private func setLayout() {
        eyeIconButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
    
    public func eyeIconButtonVisible() {
        eyeIconButton.isHidden = false
    }
}
