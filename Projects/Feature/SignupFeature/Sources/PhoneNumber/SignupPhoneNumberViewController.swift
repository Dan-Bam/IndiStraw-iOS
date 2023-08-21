import UIKit
import BaseFeature
import DesignSystem
import RxSwift
import RxCocoa
import Utility

public class SignupPhoneNumberViewController: BaseVC<SignupPhoneNumberViewModel>,
                                              InputPhoneNumberComponentProtocol  {
    let component = InputPhoneNumberComponent()
    
    public override func configureVC() {
        navigationItem.title = "전화번호를 입력해주세요."
        
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

extension SignupPhoneNumberViewController {
    public func checkDuplicationPhoneNumber(phoneNumber: String) {
        viewModel.requestToCheckDuplicationPhoneNumber(phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .success:
                self?.requestToSendAuthNumber(phoneNumber: phoneNumber)
            case .failure(.duplicatePhoneNumber):
                self?.component.changeErrorText(text: "이미 등록된 전화번호 입니다.")
            default:
                self?.component.changeErrorText(text: "인증에 실패했습니다.")
            }
        }
    }
    
    public func requestToSendAuthNumber(phoneNumber: String) {
        viewModel.requestToSendAuthNumber(phoneNumber: phoneNumber) { [weak self] response in
            switch response {
            case .success:
                DispatchQueue.main.async {
                    self?.component.continueButton.tag = 1
                    self?.component.changeErrorText(text: nil)
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

    public func resendButtonDidTap(phoneNumber: String) {
        viewModel.requestToSendAuthNumber(phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .success:
                self?.component.setupPossibleBackgroundTimer()
            case .failure(.cantSendAuthNumber):
                self?.component.changeErrorText(text: "인증번호 전송에 실패했습니다.")
            case .failure(.tooManyRequestException):
                self?.component.changeErrorText(text: "최대 요청횟수를 초과했습니다. 1시간 후에 다시 시도해주세요.")
            }
        }
    }
    
    public func checkAuthCode(authCode: String, phoneNumber: String) {
        viewModel.requestToCheckAuthNumber(authCode: authCode, phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .success:
                self?.viewModel.pushProfileImageVC(phoneNumber: phoneNumber)
            case .failure(.cantSendAuthNumber):
                self?.component.changeErrorText(text: "인증번호가 틀렸습니다.")
            case .failure(.tooManyRequestException):
                self?.component.changeErrorText(text: "최대 인증확인 요청 횟수를 초과했습니다. 1시간 후에 다시 시도해주세요")
            }
        }
    }
}
