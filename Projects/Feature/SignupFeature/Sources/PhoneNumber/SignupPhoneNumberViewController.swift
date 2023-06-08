import UIKit
import BaseFeature
import DesignSystem
import RxSwift
import RxCocoa
import Utility

class SignupPhoneNumberViewController: BaseVC<SignupPhoneNumberViewModel> {
    var name: String?
    
    private var isValidAuth = true
    
    private let disposeBag = DisposeBag()
    
    private let inputPhoneNumberTextField = TextFieldBox().then {
        $0.setPlaceholer(text: "전화번호")
    }
    
    private let inputAuthNumberTextField = TextFieldBox().then {
        $0.setPlaceholer(text: "인증번호")
    }
    
    private let countLabel = UILabel().then {
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 14)
    }
    
    private let errorLabel = ErrorLabel()
    
    private let continueButton = ButtonComponent().then {
        $0.setTitle("계속하기", for: .normal)
    }
    
    private let againReciveAuthNumberButton = UIButton().then {
        $0.setTitle("인증번호가 안오셨나요? 재전송", for: .normal)
        $0.titleLabel?.font = DesignSystemFontFamily.Suit.medium.font(size: 12)
    }
    
    private func setAgainReciveAuthNumberButtonAttributedTitle() {
        guard let text = againReciveAuthNumberButton.titleLabel?.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttributes([
            .foregroundColor : UIColor.white,
            .font : DesignSystemFontFamily.Suit.bold.font(size: 12) as Any
        ],
        range: (text as NSString).range(of: "재전송"))
        
        againReciveAuthNumberButton.setAttributedTitle(attributeString, for: .normal)
    }
    
    func requestAuthButtonDidTap(phoneNumber: String) {
        LoadingIndicator.showLoading(text: "")
        
        guard phoneNumber.hasPrefix("010") else {
            errorLabel.text = "전화번호 형식이 올바르지 않습니다."
            LoadingIndicator.hideLoading()
            return
        }
        
        viewModel.requestDuplicatePhoneNumber(phoneNumber: phoneNumber)
    }
    
    init(viewModel: SignupPhoneNumberViewModel, name: String) {
        super.init(viewModel: viewModel)
        self.name = name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureVC() {
        navigationItem.title = "전화번호를 입력해주세요."
        
        setAgainReciveAuthNumberButtonAttributedTitle()
        
        continueButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.requestAuthNumber()
            }.disposed(by: disposeBag)
    }
    
    func requestAuthNumber() {
        let phoneNumber = inputPhoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if phoneNumber.isEmpty { return errorLabel.text = "전화번호를 입력해주세요" }
        guard phoneNumber.hasPrefix("010") else {
            errorLabel.text = "전화번호 형식이 올바르지 않아요."
            LoadingIndicator.hideLoading()
            return
        }
        
        viewModel.requestDuplicatePhoneNumber(phoneNumber: phoneNumber) { [weak self] response in
            switch response {
            case .success:
                print("asdf")
                DispatchQueue.main.async {
                    self?.errorLabel.text = nil
                    self?.navigationItem.title = "인증번호를 입력해 주세요."
                    self?.continueButton.setTitle("인증번호 확인", for: .normal)
                    self?.updateAuthNumberTextFieldLayout()
                }
            case .failure(let error):
                print("asdf")
            }
        }
    }
    
    override func addView() {
        view.addSubviews(
            inputPhoneNumberTextField, continueButton,
            inputAuthNumberTextField, againReciveAuthNumberButton,
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
        
        againReciveAuthNumberButton.snp.makeConstraints {
            $0.top.equalTo(continueButton.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
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
    }
}

extension SignupPhoneNumberViewController {
    private func setupPossibleBackgroundTimer() {
        let count = 180
        
        
        isValidAuth = false
        
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .take(count+1)
            .map { count - $0 }
            .bind(with: self) { owner, remainingSeconds in
                let minutes = remainingSeconds / 60
                let seconds = remainingSeconds % 60
                owner.countLabel.text = String(format: "%02d:%02d", minutes, seconds)
                
                if remainingSeconds == 0 {
                    owner.countLabel.text = "00:00"
                    owner.isValidAuth = true
                }
            }.disposed(by: disposeBag)
    }
}
