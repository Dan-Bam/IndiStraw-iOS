import UIKit
import BaseFeature
import DesignSystem

class SignupPasswordViewController: BaseVC<SignupPasswordViewModel> {
    private let inputPasswordTextField = TextFieldBox().then {
        $0.setPlaceholer(text: "비밀번호")
    }
    
    private let inputCheckPasswordTextField = TextFieldBox().then {
        $0.setPlaceholer(text: "비밀번호 확인")
    }
    
    private let confirmButton = ButtonComponent().then {
        $0.setTitle("확인하기", for: .normal)
    }
    
    private let errorLabel = ErrorLabel()
    
    
    override func configureVC() {
        navigationItem.title = "비밀번호를 입력해 주세요."
    }
    
    override func addView() {
        view.addSubviews(inputPasswordTextField, inputCheckPasswordTextField,
                         confirmButton, errorLabel)
    }
    
    override func setLayout() {
        inputPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(140)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        inputCheckPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(inputPasswordTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(inputCheckPasswordTextField.snp.bottom).offset(7)
            $0.leading.equalTo(inputCheckPasswordTextField.snp.leading)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(inputCheckPasswordTextField.snp.bottom).offset(37)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
    }
}
