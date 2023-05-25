import UIKit
import BaseFeature
import DesignSystem
import Utility

class RootViewController: BaseVC<RootViewModel> {
    private let logoLabel = UILabel().then {
        $0.text = "Indi Straw"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.bold.font(size: 30)
    }
    
    private lazy var signinButton = ButtonComponent().then {
        $0.setTitle("로그인", for: .normal)
        $0.addTarget(self, action: #selector(signinButtonDidTap(_:)), for: .touchUpInside)
    }
    
    private let signupButton = UIButton().then {
        $0.setTitle("계정이 없으신가요? 회원가입 하러가기", for: .normal)
        $0.setTitleColor(DesignSystemAsset.exampleText.color, for: .normal)
        $0.titleLabel?.font = DesignSystemFontFamily.Suit.regular.font(size: 12)
    }
    
    override func configureVC() {
        setSignupButtonAttributedTitle()
    }
    
    @objc func signinButtonDidTap(_ tap: UIButton) {
        print("hi")
        viewModel.pushSignin()
    }
    
    private func setSignupButtonAttributedTitle() {
        guard let text = signupButton.titleLabel?.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttributes([
            .foregroundColor : UIColor.white,
            .font : DesignSystemFontFamily.Suit.bold.font(size: 12) as Any
        ],
        range: (text as NSString).range(of: "회원가입"))
        
        signupButton.setAttributedTitle(attributeString, for: .normal)
    }
    
    override func addView() {
        view.addSubviews(logoLabel, signinButton, signupButton)
    }
    
    override func setLayout() {
        logoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(287)
            $0.centerX.equalToSuperview()
        }
        
        signinButton.snp.makeConstraints {
            $0.bottom.equalTo(signupButton.snp.top).offset(-33)
            $0.leading.trailing.equalToSuperview().inset(33)
            $0.height.equalTo(54)
        }
        
        signupButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(39)
            $0.centerX.equalToSuperview()
        }
    }
}
