import Foundation
import BaseFeature

class SignupNameViewModel: BaseViewModel {
    func pushInputPhoneNumberVC(name: String) {
        coordinator.navigate(to: .inputPhoneNumberIsRequired(name: name))
    }
}
