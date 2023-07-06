import Foundation
import BaseFeature
import DesignSystem
import RxSwift
import RxCocoa

class SignupIDViewController: BaseVC<SignupIDViewModel> {
    private let disposeBag = DisposeBag()
    
    private let inputIDTextField = TextFieldBoxComponent().then {
        $0.setPlaceholer(text: "아이디")
    }
    
    private let continueButton = ButtonComponent().then {
        $0.setTitle("계속하기", for: .normal)
    }
    
    private var errorLabel = ErrorLabel()
    
    override func configureVC() {
        navigationItem.title = "아이디를 입력해주세요"
        
        continueButton.rx.tap
            .bind(with: self) { owner, _ in
                let id = owner.inputIDTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                if id.isEmpty {
                    owner.errorLabel.text = "아이디를 입력해주세요."
                } else if !(6...15).contains(id.count) {
                    owner.errorLabel.text = "6~15 글자로 입력해주세요."
                } else {
                    owner.viewModel.requestToCheckDuplicationID(id: id) { result in
                        switch result {
                        case .success:
                            owner.viewModel.pushPasswordVC(id: id)
                        case .failure:
                            owner.errorLabel.text = "이미 있는 아이디입니다."
                        }
                    }
                    
                }
            }.disposed(by: disposeBag)
    }
    
    override func addView() {
        view.addSubviews(inputIDTextField, continueButton, errorLabel)
    }
    
    override func setLayout() {
        inputIDTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(171)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(inputIDTextField.snp.bottom).offset(7)
            $0.leading.equalTo(inputIDTextField.snp.leading)
        }
        
        continueButton.snp.makeConstraints {
            $0.top.equalTo(inputIDTextField.snp.bottom).offset(78)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
    }
}
