import UIKit
import BaseFeature
import Utility
import DesignSystem
import RxSwift
import RxCocoa

public class SigninViewController: BaseVC<SigninViewModel> {
    private let disposeBag = DisposeBag()
    
    private let inputIDTextField = TextFieldBox().then {
        $0.setPlaceholer(text: "아이디")
    }
    
    private let inputPasswordTextField = TextFieldBox().then {
        $0.setPlaceholer(text: "비밀번호")
        $0.eyeIconButtonVisible()
    }
    
    private let errorLabel = ErrorLabel()
    
    private let signinButton = ButtonComponent().then {
        $0.setTitle("로그인", for: .normal)
    }
    
    private let findIDButton = UIButton().then {
        $0.setTitle("아이디 찾기 |", for: .normal)
        $0.setTitleColor(DesignSystemAsset.Colors.gray.color, for: .normal)
        $0.titleLabel?.font = DesignSystemFontFamily.Suit.regular.font(size: 12)
    }
    
    private let findPasswordButton = UIButton().then {
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.setTitleColor(DesignSystemAsset.Colors.gray.color, for: .normal)
        $0.titleLabel?.font = DesignSystemFontFamily.Suit.regular.font(size: 12)
    }
    
    public override func configureVC() {
        navigationItem.title = "로그인 하기"
        
        signinButton.rx.tap
            .bind(with: self) { owner, _ in
                let id = owner.inputIDTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = owner.inputPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                if id.isEmpty { return owner.errorLabel.text = "아이디를 입력해주세요." }
                if password.isEmpty { return owner.errorLabel.text = "비밀번호를 입력해주세요." }
                
                if owner.viewModel.isValidPassword(password: password) {
                    owner.viewModel.requestToSignin(request: SigninRequest(id: id, password: password)) { result in
                        switch result {
                        case .success:
                            print("success")
                            owner.viewModel.setHomeView()
                        case .failure:
                            owner.errorLabel.text = "존재하지 않는 아이디입니다."
                        }
                    }
                } else {
                    owner.errorLabel.text = "올바르지 않은 비밀번호입니다."
                }
            }.disposed(by: disposeBag)
        
        findIDButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.viewModel.pushPhoneNumberAuth(type: .findId)
            }.disposed(by: disposeBag)
        
        findPasswordButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.viewModel.pushPhoneNumberAuth(type: .changePassword)
            }.disposed(by: disposeBag)
    }
    
    public override func addView() {
        view.addSubviews(
            inputIDTextField, inputPasswordTextField,
            findIDButton, findPasswordButton,
            signinButton, errorLabel
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
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(inputPasswordTextField.snp.bottom).offset(7)
            $0.leading.equalTo(inputPasswordTextField.snp.leading)
        }
        
        signinButton.snp.makeConstraints {
            $0.top.equalTo(inputPasswordTextField.snp.bottom).offset(57)
            $0.leading.trailing.equalToSuperview().inset(33)
            $0.height.equalTo(54)
        }
        
        findPasswordButton.snp.makeConstraints {
            $0.top.equalTo(signinButton.snp.bottom).offset(10)
            $0.leading.equalTo(findIDButton.snp.trailing).offset(4)
        }
        
        findIDButton.snp.makeConstraints {
            $0.top.equalTo(findPasswordButton.snp.top)
            $0.trailing.equalTo(signinButton.snp.centerX)
        }
    }
}
