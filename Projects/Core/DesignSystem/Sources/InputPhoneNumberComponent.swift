import UIKit
import RxSwift
import RxCocoa
import Utility

class InputPhoneNumberComponent: UIView {
    
    private var disposeBag = DisposeBag()
    
    private var timerDisposable: Disposable?
    
    private let inputPhoneNumberTextField = TextFieldBox().then {
        $0.keyboardType = .numberPad
        $0.setPlaceholer(text: "전화번호")
    }
    
    private let inputAuthNumberTextField = TextFieldBox().then {
        $0.keyboardType = .numberPad
        $0.setPlaceholer(text: "인증번호")
    }
    
    private let countLabel = UILabel().then {
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 14)
    }
    
    private let errorLabel = ErrorLabel()
    
    private let continueButton = ButtonComponent().then {
        $0.tag = 0
        $0.setTitle("계속하기", for: .normal)
    }
    
    private let resendAuthNumberButton = UIButton().then {
        $0.setTitle("인증번호가 안오셨나요? 재전송", for: .normal)
        $0.titleLabel?.font = DesignSystemFontFamily.Suit.medium.font(size: 12)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        self.addSubviews(
            inputPhoneNumberTextField, continueButton,
            inputAuthNumberTextField, resendAuthNumberButton,
            countLabel, errorLabel)
        inputAuthNumberTextField.addSubview(countLabel)
    }
    
    func setLayout() {
        inputPhoneNumberTextField.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(171)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(inputPhoneNumberTextField.snp.bottom).offset(7)
            $0.leading.equalTo(inputPhoneNumberTextField.snp.leading)
        }
        
        continueButton.snp.makeConstraints {
            $0.top.equalTo(inputPhoneNumberTextField.snp.bottom).offset(78)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
    }
}
