import UIKit
import BaseFeature
import DesignSystem
import RxSwift
import RxCocoa

class SignupPasswordViewController: BaseVC<SignupPasswordViewModel>, AllAgreeButtonDidTapProtocol {
    let vc = PrivacyBottomSheet()
    
    var isValidPassword = false

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
    
    func showEmptyPasswordError(password: String, checkPassword: String) {
        if password.isEmpty {
            errorLabel.text = "비밀번호를 입력해주세요."
            isValidPassword = false
        } else if checkPassword.isEmpty {
            errorLabel.text = "비밀번호 확인을 입력해주세요."
            isValidPassword = false
        } else {
            isValidPassword(password: password, checkPassword: checkPassword)
        }
    }
    
    func isValidPassword(password: String, checkPassword: String) {
        guard viewModel.isValidPassword(password: password) else {
            errorLabel.text = "숫자와 대소문자, 특수문자를 포함해주세요."
            isValidPassword = false
            return
        }
        
        guard (8...20).contains(password.count) else {
            errorLabel.text = "8~20자 사이로 입력해주세요."
            isValidPassword = false
            return
        }
        
        isPasswordMatch(password: password, checkPassword: checkPassword)
    }
    
    func isPasswordMatch(password: String, checkPassword: String) {
        if password != checkPassword {
            errorLabel.text = "비밀번호가 일치하지 않습니다."
            isValidPassword = false
            return
        }
        
        isValidPassword = true
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
                owner.showEmptyPasswordError(password: password, checkPassword: checkPassword)
                
                if owner.isValidPassword {
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
