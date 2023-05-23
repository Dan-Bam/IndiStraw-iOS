import UIKit
import Then
import SnapKit
import DesignSystem

final class TextFieldBox: UITextField {
    private let eyeIconButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye"), for: .normal)
        $0.tintColor = DesignSystemAsset.exampleText.color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        backgroundColor = DesignSystemAsset.textBox.color
        
        addView()
        setLayout()
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
}
