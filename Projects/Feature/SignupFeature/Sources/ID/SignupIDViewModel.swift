import Foundation
import BaseFeature

class SignupIDViewModel: BaseViewModel {
    func pushPasswordVC() {
        coordinator.navigate(to: .inputPasswordIsRequired)
    }
}
