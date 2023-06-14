import UIKit
import BaseFeature
import DesignSystem

class PasswordInputPhoneNumberViewController: BaseVC<PasswordInputPhoneNumberViewModel> {
    private let component = InputPhoneNumberComponent()
    
    override func configureVC() {
        
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
