import UIKit
import BaseFeature
import DesignSystem

class InputPhoneNumberViewController: BaseVC<PasswordInputPhoneNumberViewModel>, InputPhoneNumberComponentProtocol {
    private let component = InputPhoneNumberComponent()
    
    override func configureVC() {
        navigationItem.title = "전화번호를 입력해 주세요."
        
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
}

extension PasswordInputPhoneNumberViewController {
    func checkDuplicationPhoneNumber(phoneNumber: String) {
        <#code#>
    }
    
    func requestToSendAuthNumber(phoneNumber: String) {
        <#code#>
    }
    
    func resendButtonDidTap(phoneNumber: String) {
        <#code#>
    }
    
    func checkAuthCode(authCode: String, phoneNumber: String) {
        <#code#>
    }
}
