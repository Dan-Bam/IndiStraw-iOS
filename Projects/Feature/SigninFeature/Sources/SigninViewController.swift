import UIKit
import BaseFeature
import Utility
import DesignSystem

public class SigninViewController: BaseVC<SigninViewModel> {
    private let inputIDTextField = TextFieldBox().then {
        $0.setPlaceholer(text: "아이디")
    }
    
    private let categoryButton = CategoryButton(configuration: .plain()).then {
        $0.setTitle("# asdfasfdafas", for: .normal)
    }
    
    private let inputPasswordTextField = TextFieldBox().then {
        $0.setPlaceholer(text: "비밀번호")
        $0.eyeIconButtonVisible()
    }
    
    private let findIDButton = UIButton().then {
        $0.setTitle("아이디 찾기 |", for: .normal)
        $0.setTitleColor(DesignSystemAsset.exampleText.color, for: .normal)
        $0.titleLabel?.font = DesignSystemFontFamily.Suit.regular.font(size: 12)
    }
    
    private let findPasswordButton = UIButton().then {
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.setTitleColor(DesignSystemAsset.exampleText.color, for: .normal)
        $0.titleLabel?.font = DesignSystemFontFamily.Suit.regular.font(size: 12)
    }
    
    private let signinButton = ButtonComponent().then {
        $0.setTitle("로그인", for: .normal)
    }
    
    public override func configureVC() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "로그인 하기"
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        view.backgroundColor = .black
    }
    
    public override func addView() {
        view.addSubviews(
            inputIDTextField, inputPasswordTextField,
            findIDButton, findPasswordButton,
            signinButton, categoryButton
        )
    }
    
    public override func setLayout() {
        inputIDTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(140)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        inputPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(inputIDTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        findPasswordButton.snp.makeConstraints {
            $0.top.equalTo(inputPasswordTextField.snp.bottom).offset(10)
            $0.trailing.equalTo(inputPasswordTextField.snp.trailing)
        }
        
        findIDButton.snp.makeConstraints {
            $0.top.equalTo(findPasswordButton.snp.top)
            $0.trailing.equalTo(findPasswordButton.snp.leading).offset(-4)
        }
        
        signinButton.snp.makeConstraints {
            $0.top.equalTo(inputPasswordTextField.snp.bottom).offset(129)
            $0.leading.trailing.equalToSuperview().inset(33)
            $0.height.equalTo(54)
        }
        
        categoryButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
}
