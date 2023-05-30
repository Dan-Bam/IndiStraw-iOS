import UIKit
import BaseFeature
import DesignSystem

class SignupNameViewController: BaseVC<SignupNameViewModel> {
    private let inputNameTextField = TextFieldBox().then {
        $0.setPlaceholer(text: "이름")
    }
    
    private let continueButton = ButtonComponent().then {
        $0.setTitle("계속하기", for: .normal)
    }
    
    override func configureVC() {
        navigationItem.title = "이름을 입력해주세요."
    }
    
    override func addView() {
        view.addSubviews(inputNameTextField, continueButton)
    }
    
    override func setLayout() {
        inputNameTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(96)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        continueButton.snp.makeConstraints {
            $0.top.equalTo(inputNameTextField.snp.bottom).offset(78)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
    }
}
