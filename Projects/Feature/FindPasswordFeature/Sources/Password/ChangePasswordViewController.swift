import UIKit
import BaseFeature
import DesignSystem

class ChangePasswordViewController: BaseVC<ChangePasswordViewModel>, InputPasswordComponentProtocol {
    let component = InputPasswordComponent()
    
    override func configureVC() {
        navigationItem.title = "비밀번호 변경"
        
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

extension ChangePasswordViewController {
    func isValidPassword(password: String) {
        guard viewModel.isValidPassword(password: password) else {
            component.errorLabel.text = "숫자와 대소문자, 특수문자를 포함해주세요."
            component.isValidPassword = false
            return
        }
    }
    
    func confirmButtonDidTap(password: String) {
        viewModel.requestToChangePassword(newPassword: password) { [weak self] result in
            switch result {
            case .success:
                self?.viewModel.popToRootVC()
            case .failure(.sameAsExistingPassword):
                self?.component.errorLabel.text = "기존 비밀번호와 같은 비밀번호입니다."
            case .failure(.failedRequest):
                self?.component.errorLabel.text = "비밀번호 변경에 실패했습니다."
            }
        }
    }
}
