import UIKit
import BaseFeature
import Utility
import DesignSystem

public class SigninViewController: BaseVC<SigninViewModel> {
    private let inputIDTextField = TextFieldBox().then {
        $0.setPlaceholer(text: "아이디")
    }
    
    private let inputPasswordTextField = TextFieldBox().then {
        $0.setPlaceholer(text: "비밀번호")
        $0.eyeIconButtonVisible()
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
        view.addSubviews(inputIDTextField, inputPasswordTextField, signinButton)
    }
    
    public override func setLayout() {
        inputIDTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(150)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        inputPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(inputIDTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        signinButton.snp.makeConstraints {
            $0.top.equalTo(inputPasswordTextField.snp.bottom).offset(129)
            $0.leading.trailing.equalToSuperview().inset(33)
            $0.height.equalTo(54)
        }
    }
}
