import UIKit
import BaseFeature
import DesignSystem

public class InputPhoneNumberViewController: BaseVC<InputPhoneNumberViewModel>, InputPhoneNumberComponentProtocol {
    private let component = InputPhoneNumberComponent()
    
    var type: FindAccountType
    
    public init(viewModel: InputPhoneNumberViewModel, type: FindAccountType) {
        self.type = type
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func configureVC() {
        navigationItem.title = "전화번호를 입력해 주세요."
        
        component.delegate = self
    }
    
    public override func addView() {
        view.addSubview(component)
    }
    
    public override func setLayout() {
        component.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension InputPhoneNumberViewController {
    public func checkDuplicationPhoneNumber(phoneNumber: String) {
        viewModel.requestToCheckDuplicationPhoneNumber(phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .success:
                self?.requestToSendAuthNumber(phoneNumber: phoneNumber)
            case .failure(.cantFindPhoneNumber):
                self?.component.errorLabel.text = "등록되지 않은 전화번호 입니다."
            default:
                self?.component.errorLabel.text = "인증에 실패했습니다."
            }
        }
    }
    
    public func requestToSendAuthNumber(phoneNumber: String) {
        viewModel.requestToSendAuthNumber(phoneNumber: phoneNumber) { [weak self] response in
            switch response {
            case .success:
                DispatchQueue.main.async {
                    self?.component.continueButton.tag = 1
                    self?.component.errorLabel.text = nil
                    self?.navigationItem.title = "인증번호를 입력해 주세요."
                    self?.component.continueButton.setTitle("인증번호 확인", for: .normal)
                    self?.component.updateAuthNumberTextFieldLayout()
                    self?.component.setupPossibleBackgroundTimer()
                }
            case .failure(.tooManyRequestException):
                self?.component.errorLabel.text = "최대 요청 횟수를 초과했습니다. 한 시간 후에 시도해주세요."
            case .failure(.cantSendAuthNumber):
                self?.component.errorLabel.text = "인증번호 요청을 실패했습니다."
            }
        }
    }

    public func resendButtonDidTap(phoneNumber: String) {
        viewModel.requestToSendAuthNumber(phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .success:
                self?.component.setupPossibleBackgroundTimer()
            case .failure(.cantSendAuthNumber):
                self?.component.errorLabel.text = "인증번호 전송에 실패했습니다."
            case .failure(.tooManyRequestException):
                self?.component.errorLabel.text = "최대 요청횟수를 초과했습니다. 1시간 후에 다시 시도해주세요."
            }
        }
    }
    
    public func checkAuthCode(authCode: String, phoneNumber: String) {
        viewModel.requestToCheckAuthNumber(authCode: authCode, phoneNumber: phoneNumber) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                switch self.type {
                case .findId:
                    self.viewModel.pushFindId(phoneNumber: phoneNumber)
                case .changePassword:
                    self.viewModel.pushChangePassword(phoneNumber: phoneNumber)
                }
            case .failure(.cantSendAuthNumber):
                self.component.errorLabel.text = "인증번호가 틀렸습니다."
            case .failure(.tooManyRequestException):
                self.component.errorLabel.text = "최대 인증확인 요청 횟수를 초과했습니다. 1시간 후에 다시 시도해주세요"
            }
        }
    }
}
