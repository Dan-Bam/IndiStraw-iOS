import BaseFeature
import UIKit

class SignupProfileImageViewModel: BaseViewModel {
    func pushInputIDVC() {
        coordinator.navigate(to: .inputIDIsRequired)
    }
}
