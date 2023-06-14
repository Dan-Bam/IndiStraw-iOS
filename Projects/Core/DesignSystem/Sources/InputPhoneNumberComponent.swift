import UIKit
import RxSwift
import RxCocoa
import Utility

public protocol InputPhoneNumberComponentProtocol: AnyObject {
    func checkDuplicationPhoneNumber(phoneNumber: String)
    func requestToSendAuthNumber(phoneNumber: String)
    func resendButtonDidTap(phoneNumber: String)
    func checkAuthCode(authCode: String, phoneNumber: String)
}

public class InputPhoneNumberComponent: UIView {
    public weak var delegate: InputPhoneNumberComponentProtocol?
    
    var disposeBag = DisposeBag()
    
    var timerDisposable: Disposable?
    
    public let inputPhoneNumberTextField = TextFieldBox().then {
        $0.keyboardType = .numberPad
        $0.setPlaceholer(text: "전화번호")
    }
    
    let inputAuthNumberTextField = TextFieldBox().then {
        $0.keyboardType = .numberPad
        $0.setPlaceholer(text: "인증번호")
    }
    
    let countLabel = UILabel().then {
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 14)
    }
    
    public let errorLabel = ErrorLabel()
    
    public let continueButton = ButtonComponent().then {
        $0.tag = 0
        $0.setTitle("계속하기", for: .normal)
    }
    
    let resendAuthNumberButton = UIButton().then {
        $0.setTitle("인증번호가 안오셨나요? 재전송", for: .normal)
        $0.titleLabel?.font = DesignSystemFontFamily.Suit.medium.font(size: 12)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        addView()
        setLayout()
        bindUI()
        
        setAgainReciveAuthNumberButtonAttributedTitle()
        
        continueButton.rx.tap
            .bind(with: self) { owner, _ in
                if owner.continueButton.tag == 0 {
                    owner.checkDuplicationPhoneNumber()
                } else {
                    owner.checkAuthCode()
                }
            }.disposed(by: disposeBag)
        
        resendAuthNumberButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.resendButtonDidTap()
            }.disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView() {
        self.addSubviews(
            inputPhoneNumberTextField, errorLabel,
            continueButton, inputAuthNumberTextField,
            resendAuthNumberButton)
        inputAuthNumberTextField.addSubview(countLabel)
    }
    
    private func setLayout() {
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
    
    public func updateAuthNumberTextFieldLayout() {
        inputPhoneNumberTextField.snp.updateConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(140)
        }
        
        inputAuthNumberTextField.snp.makeConstraints {
            $0.top.equalTo(inputPhoneNumberTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        errorLabel.snp.updateConstraints {
            $0.top.equalTo(inputPhoneNumberTextField.snp.bottom).offset(81)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(14)
        }
        
        continueButton.snp.updateConstraints {
            $0.top.equalTo(inputPhoneNumberTextField.snp.bottom).offset(111)
        }
        
        resendAuthNumberButton.snp.makeConstraints {
            $0.top.equalTo(continueButton.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func bindUI() {
        let maxLength = 4
        
        inputAuthNumberTextField.rx.text.orEmpty
            .map { text -> String in
                let truncatedText = String(text.prefix(maxLength))
                return truncatedText
            }
            .bind(with: self, onNext: { owner, text in
                owner.inputAuthNumberTextField.text = text
            }).disposed(by: disposeBag)
        
        inputPhoneNumberTextField.rx.text.orEmpty
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).count >= 11 }
            .bind(with: self) { owner, isValid in
                if isValid {
                    owner.inputPhoneNumberTextField.isEnabled = false
                    owner.inputPhoneNumberTextField.resignFirstResponder()
                }
            }.disposed(by: disposeBag)
    }
    
    private func setAgainReciveAuthNumberButtonAttributedTitle() {
        guard let text = resendAuthNumberButton.titleLabel?.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttributes([
            .foregroundColor : UIColor.white,
            .font : DesignSystemFontFamily.Suit.bold.font(size: 12) as Any
        ], range: (text as NSString).range(of: "재전송"))
        resendAuthNumberButton.setAttributedTitle(attributeString, for: .normal)
    }
    
    public func setupPossibleBackgroundTimer() {
        timerDisposable?.dispose()
        let count = 300
        
        timerDisposable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .take(count+1)
            .map { count - $0 }
            .bind(with: self) { owner, remainingSeconds in
                let minutes = remainingSeconds / 60
                let seconds = remainingSeconds % 60
                owner.countLabel.text = String(format: "%02d:%02d", minutes, seconds)
                
                if remainingSeconds == 0 {
                    owner.countLabel.text = "00:00"
                }
            }
        timerDisposable?.disposed(by: disposeBag)
    }
}


extension InputPhoneNumberComponent{
    private func checkDuplicationPhoneNumber() {
        let phoneNumber = inputPhoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if phoneNumber.isEmpty { return errorLabel.text = "전화번호를 입력해주세요" }
        guard phoneNumber.hasPrefix("010") else {
            errorLabel.text = "전화번호 형식이 올바르지 않아요."
            LoadingIndicator.hideLoading()
            return
        }
        
        delegate?.checkDuplicationPhoneNumber(phoneNumber: phoneNumber)
    }
    
    private func requestToSendAuthNumber(phoneNumber: String) {
        delegate?.requestToSendAuthNumber(phoneNumber: phoneNumber)
    }

    private func resendButtonDidTap() {
        let phoneNumber = inputPhoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        delegate?.resendButtonDidTap(phoneNumber: phoneNumber)
    }
    
    private func checkAuthCode() {
        let authCode = inputAuthNumberTextField.text!
        let phoneNumber = inputPhoneNumberTextField.text!
        
        delegate?.checkAuthCode(authCode: authCode, phoneNumber: phoneNumber)
    }
}
