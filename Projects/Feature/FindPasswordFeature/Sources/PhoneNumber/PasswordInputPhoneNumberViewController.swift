import UIKit
import BaseFeature
import DesignSystem

class PasswordInputPhoneNumberViewController: BaseVC<PasswordInputPhoneNumberViewModel> {
    private let component = InputPhoneNumberComponent()
    
    override func configureVC() {
        navigationItem.title = "전화번호를 입력해 주세요."
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
