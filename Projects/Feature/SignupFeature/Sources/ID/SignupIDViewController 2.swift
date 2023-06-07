import Foundation
import BaseFeature
import DesignSystem
import RxSwift
import RxCocoa

class SignupIDViewController: BaseVC<SignupIDViewModel> {
    private let disposeBag = DisposeBag()
    private let inputIDTextField = TextFieldBox().then {
        $0.setPlaceholer(text: "아이디")
    }
    
    private let continueButton = ButtonComponent().then {
        $0.setTitle("계속하기", for: .normal)
    }
    override func configureVC() {
        navigationItem.title = "아이디를 입력해주세요"
        
        continueButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.viewModel.pushPasswordVC()
                
            }.disposed(by: disposeBag)
    }
    
    override func addView() {
        view.addSubviews(inputIDTextField, continueButton)
    }
    
    override func setLayout() {
        inputIDTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(171)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        continueButton.snp.makeConstraints {
            $0.top.equalTo(inputIDTextField.snp.bottom).offset(78)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
    }
}
