import UIKit
import BaseFeature
import DesignSystem
import RxSwift
import RxCocoa

class SignupNameViewController: BaseVC<SignupNameViewModel> {
    private let disposeBag = DisposeBag()
    
    private let inputNameTextField = TextFieldBoxComponent().then {
        $0.setPlaceholer(text: "이름")
    }
    
    private let continueButton = ButtonComponent().then {
        $0.setTitle("계속하기", for: .normal)
    }
    
    private let errorLabel = ErrorLabelComponent()
    
    override func configureVC() {
        navigationItem.title = "이름을 입력해주세요."
        
        continueButton.rx.tap
            .bind(with: self) { owner, _ in
                let name = owner.inputNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                if name.isEmpty {
                    owner.errorLabel.text = "이름을 입력해주세요."
                } else {
                    owner.viewModel.pushInputPhoneNumberVC(name: name)
                }
            }.disposed(by: disposeBag)
    }
    
    override func addView() {
        view.addSubviews(inputNameTextField, continueButton, errorLabel)
    }
    
    override func setLayout() {
        inputNameTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(171)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(inputNameTextField.snp.bottom).offset(7)
            $0.leading.equalTo(inputNameTextField.snp.leading)
        }
        
        continueButton.snp.makeConstraints {
            $0.top.equalTo(inputNameTextField.snp.bottom).offset(78)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
    }
}
