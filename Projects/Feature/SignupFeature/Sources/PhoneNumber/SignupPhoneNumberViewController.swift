import UIKit
import BaseFeature
import DesignSystem
import RxSwift
import RxCocoa

class SignupPhoneNumberViewController: BaseVC<SignupPhoneNumberViewModel> {
    private let disposeBag = DisposeBag()
    
    private let inputNameTextField = TextFieldBox().then {
        $0.setPlaceholer(text: "전화번호")
    }
    
    private let inputAuthNumberTextField = TextFieldBox().then {
        $0.setPlaceholer(text: "인증번호")
    }
    
    private let continueButton = ButtonComponent().then {
        $0.setTitle("계속하기", for: .normal)
    }
    
    private let againReciveAuthNumberButton = UIButton().then {
        $0.setTitle("인증번호가 안오셨나요? 다시받기", for: .normal)
        $0.titleLabel?.font = DesignSystemFontFamily.Suit.medium.font(size: 12)
    }
    
    private func setSignupButtonAttributedTitle() {
        guard let text = againReciveAuthNumberButton.titleLabel?.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttributes([
            .foregroundColor : UIColor.white,
            .font : DesignSystemFontFamily.Suit.bold.font(size: 12) as Any
        ],
        range: (text as NSString).range(of: "다시받기"))
        
        againReciveAuthNumberButton.setAttributedTitle(attributeString, for: .normal)
    }
    
    override func configureVC() {
        navigationItem.title = "이름을 입력해주세요."
        
        continueButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationItem.title = "인증번호를 입력해 주세요."
                owner.continueButton.setTitle("인증번호 확인", for: .normal)
                owner.updateAuthNumberTextFieldLayout()
            }.disposed(by: disposeBag)
    }
    
    override func addView() {
        view.addSubviews(inputNameTextField, continueButton, inputAuthNumberTextField, againReciveAuthNumberButton)
    }
    
    override func setLayout() {
        inputNameTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(171)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        continueButton.snp.makeConstraints {
            $0.top.equalTo(inputNameTextField.snp.bottom).offset(78)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
    }
    
    private func updateAuthNumberTextFieldLayout() {
        inputNameTextField.snp.updateConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(140)
        }
        
        inputAuthNumberTextField.snp.makeConstraints {
            $0.top.equalTo(inputNameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        continueButton.snp.updateConstraints {
            $0.top.equalTo(inputNameTextField.snp.bottom).offset(111)
        }
    }
}
