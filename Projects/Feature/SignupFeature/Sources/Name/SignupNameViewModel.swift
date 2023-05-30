import Foundation
import BaseFeature

class SignupNameViewModel: BaseViewModel {
    func pushInputPhoneNumberVC() {
        coordinator.navigate(to: .inputPhoneNumberIsRequired)
    }
}
