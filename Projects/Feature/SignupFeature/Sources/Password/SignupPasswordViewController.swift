import UIKit
import BaseFeature
import DesignSystem
import RxSwift
import RxCocoa

class SignupPasswordViewController: BaseVC<SignupPasswordViewModel>, AllAgreeButtonDidTapProtocol {
    let vc = PrivacyBottomSheet()

    private let disposeBag = DisposeBag()
    
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
    
    func isPasswordMatch(password: String, checkPassword: String) -> Bool {
        if password.elementsEqual(checkPassword) {
            errorLabel.text = "비밀번호가 일치하지 않습니다."
            return true
        }
        
        return false
    }
    
    func showEmptyPasswordError(password: String, checkPassword: String) -> Bool {
        if password.isEmpty {
            errorLabel.text = "비밀번호를 입력해주세요."
            return false
        } else if checkPassword.isEmpty {
            errorLabel.text = "비밀번호 확인을 입력해주세요."
            return false
        }
        
        return true
    }
    
    func isValidPassword(password: String) -> Bool {
        guard viewModel.isValidPassword(password: password) else {
            errorLabel.text = "길이는 8~20, 숫자와 대소문자, 특수문자를 포함해주세요"
            return false
        }
        
        return true
    }
    
    func presentBottomSheet() {
        vc.modalPresentationStyle = .pageSheet
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        present(vc, animated: true)
    }
    
    override func configureVC() {
        navigationItem.title = "비밀번호를 입력해 주세요."
        vc.delegate = self
        
        confirmButton.rx.tap
            .bind(with: self) { owner, _ in
                let password = owner.inputPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let checkPassword = owner.inputCheckPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
                if owner.showEmptyPasswordError(password: password, checkPassword: checkPassword) && owner.isPasswordMatch(password: password, checkPassword: checkPassword) && owner.isValidPassword(password: password) {
                    owner.presentBottomSheet()
                }
                
            }.disposed(by: disposeBag)
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

extension SignupPasswordViewController {
    func allAgreeButtonDidTap() {
        dismiss(animated: true)
        viewModel.popToRootVC()
    }
}
