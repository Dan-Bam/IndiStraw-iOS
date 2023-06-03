import UIKit
import DesignSystem

class PrivacyBottomSheet: UIViewController {
    private let allAgreeWrapperButton = UIButton()
    
    private let allAgreeChildButton = UIButton().then {
        $0.layer.borderColor = DesignSystemAsset.Colors.exampleText.color.cgColor
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 5
    }
    
    private let allAgreeLabel = UILabel().then {
        $0.text = "전체동의"
        $0.textColor = .white
    }
    
    private let separatorLine = UIView().then {
        $0.backgroundColor = DesignSystemAsset.Colors.line.color
    }
    
    override func viewDidLoad() {
        view.backgroundColor = DesignSystemAsset.Colors.bottomSheet.color
        addView()
        setLayout()
    }
    
    private func addView() {
        view.addSubviews(allAgreeWrapperButton, separatorLine)
        allAgreeWrapperButton.addSubviews(allAgreeChildButton, allAgreeLabel)
    }
    
    private func setLayout() {
        allAgreeWrapperButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(58)
            $0.leading.equalToSuperview().inset(33)
        }
        
        allAgreeChildButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        allAgreeLabel.snp.makeConstraints {
            $0.centerY.equalTo(allAgreeChildButton)
            $0.leading.equalTo(allAgreeChildButton.snp.trailing).offset(13)
        }
        
        separatorLine.snp.makeConstraints {
            $0.top.equalTo(allAgreeWrapperButton.snp.bottom).offset(17)
            $0.leading.trailing.equalToSuperview().inset(33)
            $0.height.equalTo(1)
        }
    }
}
