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
//        viewModel.requestToUploadImage(image: profileImage, password: password) { [weak self] result in
//            switch result {
//            case .success(let data):
//                self?.requestToSignup(
//                    password: password,
//                    data: data
//                )
//            case .failure:
//                self?.component.errorLabel.text = "회원가입에 실패했습니다."
//            }
//        }
        viewModel.requestToChangePassword(password: password) { [weak self] result in
//            switch result {
//            case .success(<#T##Void#>)
//            }
        }
    }
}
