import UIKit
import BaseFeature
import DesignSystem
import RxSwift
import RxCocoa
import Utility

class SignupPhoneNumberViewController: BaseVC<SignupPhoneNumberViewModel> {
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
    
    private func setAgainReciveAuthNumberButtonAttributedTitle() {
        guard let text = resendAuthNumberButton.titleLabel?.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttributes([
            .foregroundColor : UIColor.white,
            .font : DesignSystemFontFamily.Suit.bold.font(size: 12) as Any
        ], range: (text as NSString).range(of: "재전송"))
        resendAuthNumberButton.setAttributedTitle(attributeString, for: .normal)
    }
    
    override func configureVC() {
        navigationItem.title = "전화번호를 입력해주세요."
        
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
        
        bindUI()
    }
    
    private func checkDuplicationPhoneNumber() {
        let phoneNumber = inputPhoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if phoneNumber.isEmpty { return errorLabel.text = "전화번호를 입력해주세요" }
        guard phoneNumber.hasPrefix("010") else {
            errorLabel.text = "전화번호 형식이 올바르지 않아요."
            LoadingIndicator.hideLoading()
            return
        }
        
        viewModel.requestToCheckDuplicationPhoneNumber(phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .success:
                self?.requestToSendAuthNumber(phoneNumber: phoneNumber)
            case .failure:
                self?.errorLabel.text = "이미 등록된 전화번호 입니다."
            }
        }
    }
    
    private func requestToSendAuthNumber(phoneNumber: String) {
        viewModel.requestToSendAuthNumber(phoneNumber: phoneNumber) { [weak self] response in
            switch response {
            case .success:
                DispatchQueue.main.async {
                    self?.continueButton.tag = 1
                    self?.errorLabel.text = nil
                    self?.navigationItem.title = "인증번호를 입력해 주세요."
                    self?.continueButton.setTitle("인증번호 확인", for: .normal)
                    self?.updateAuthNumberTextFieldLayout()
                    self?.setupPossibleBackgroundTimer()
                }
            case .failure:
                return
            }
        }
    }

    private func resendButtonDidTap() {
        let phoneNumber = inputPhoneNumberTextField.text!
        viewModel.requestToSendAuthNumber(phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .success:
                self?.setupPossibleBackgroundTimer()
            case .failure(.cantSendAuthNumber):
                self?.errorLabel.text = "인증번호 전송에 실패했습니다."
            case .failure(.tooManyRequestException):
                self?.errorLabel.text = "최대 요청횟수를 초과했습니다. 1시간 후에 다시 시도해주세요."
            }
        }
    }
    
    private func checkAuthCode() {
        let authCode = inputAuthNumberTextField.text!
        let phoneNumber = inputPhoneNumberTextField.text!
        
        viewModel.requestToCheckAuthNumber(authCode: authCode, phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .success:
                self?.viewModel.pushProfileImageVC()
            case .failure(.cantSendAuthNumber):
                self?.errorLabel.text = "인증번호가 틀렸습니다."
            case .failure(.tooManyRequestException):
                self?.errorLabel.text = "최대 인증확인 요청 횟수를 초과했습니다. 1시간 후에 다시 시도해주세요"
            }
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
                    owner.continueButton.isEnabled = true
                    owner.inputPhoneNumberTextField.isEnabled = false
                    owner.inputPhoneNumberTextField.resignFirstResponder()
                }
            }.disposed(by: disposeBag)
    }
    
    override func addView() {
        view.addSubviews(
            inputPhoneNumberTextField, continueButton,
            inputAuthNumberTextField, resendAuthNumberButton,
            countLabel, errorLabel)
        inputAuthNumberTextField.addSubview(countLabel)
    }
    
    override func setLayout() {
        inputPhoneNumberTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(171)
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
    
    private func updateAuthNumberTextFieldLayout() {
        inputPhoneNumberTextField.snp.updateConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(140)
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
}

extension SignupPhoneNumberViewController {
    private func setupPossibleBackgroundTimer() {
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
