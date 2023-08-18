import UIKit
import BaseFeature
import DesignSystem

public class ChangePasswordViewController: BaseVC<ChangePasswordViewModel>, InputPasswordComponentProtocol {
    let component = InputPasswordComponent()
    
    public override func configureVC() {
        navigationItem.title = "비밀번호 변경"
        
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

extension ChangePasswordViewController {
    public func isValidPassword(password: String) {
        guard viewModel.isValidPassword(password: password) else {
            component.changeErrorText(text: "숫자와 대소문자, 특수문자를 포함해주세요.")
            component.isValidPassword = false
            return
        }
    }
    
    public func confirmButtonDidTap(password: String) {
        viewModel.requestToChangePassword(newPassword: password) { [weak self] result in
            switch result {
            case .success:
                self?.viewModel.popToRootVC()
            case .failure(.sameAsExistingPassword):
                self?.component.changeErrorText(text: "기존 비밀번호와 같은 비밀번호입니다.")
            case .failure(.failedRequest):
                self?.component.changeErrorText(text: "비밀번호 변경에 실패했습니다.")
            }
        }
    }
}
