import Foundation
import BaseFeature

public class SignupNameViewModel: BaseViewModel {
    func pushInputPhoneNumberVC(name: String) {
        coordinator.navigate(to: .inputPhoneNumberIsRequired(name: name))
    }
}
