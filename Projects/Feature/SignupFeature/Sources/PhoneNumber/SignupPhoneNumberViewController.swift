import UIKit
import BaseFeature
import DesignSystem
import RxSwift
import RxCocoa
import Utility

class SignupPhoneNumberViewController: BaseVC<SignupPhoneNumberViewModel>, InputPhoneNumberComponentProtocol  {
    
    let component = InputPhoneNumberComponent()
    
    override func configureVC() {
        navigationItem.title = "전화번호를 입력해주세요."
        
        component.delegate = self
    }
    
    override func addView() {
        view.addSubview(component)
    }
    
    override func setLayout() {
        component.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func checkDuplicationPhoneNumber(phoneNumber: String) {
        viewModel.requestToCheckDuplicationPhoneNumber(phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .success:
                self?.requestToSendAuthNumber(phoneNumber: phoneNumber)
            case .failure:
                self?.component.errorLabel.text = "이미 등록된 전화번호 입니다."
            }
        }
    }
    
    func requestToSendAuthNumber(phoneNumber: String) {
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
            case .failure:
                return
            }
        }
    }

    func resendButtonDidTap(phoneNumber: String) {
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
    
    func checkAuthCode(authCode: String, phoneNumber: String) {
        viewModel.requestToCheckAuthNumber(authCode: authCode, phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .success:
                self?.viewModel.pushProfileImageVC(phoneNumber: phoneNumber)
            case .failure(.cantSendAuthNumber):
                self?.component.errorLabel.text = "인증번호가 틀렸습니다."
            case .failure(.tooManyRequestException):
                self?.component.errorLabel.text = "최대 인증확인 요청 횟수를 초과했습니다. 1시간 후에 다시 시도해주세요"
            }
        }
    }
}
