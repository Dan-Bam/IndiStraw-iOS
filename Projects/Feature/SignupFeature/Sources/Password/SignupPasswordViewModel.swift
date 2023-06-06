import Foundation
import BaseFeature

class SignupPasswordViewModel: BaseViewModel {
    func popToRootVC() {
        coordinator.navigate(to: .popToRootIsRequired)
    }
}
