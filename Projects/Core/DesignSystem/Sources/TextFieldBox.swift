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
        addView()
        setLayout()
        addLeftPadding()
        
        eyeIconButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.iconTaped.toggle()
                owner.isSecureTextEntry =  owner.iconTaped ? false : true
            }.disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setPlaceholer(text: String) {
        self.placeholder = text
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(
            string: string,
            attributes: [.foregroundColor: DesignSystemAsset.exampleText.color]
        )
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
    
    private func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    public func eyeIconButtonVisible() {
        isSecureTextEntry = true
        eyeIconButton.isHidden = false
    }
}

