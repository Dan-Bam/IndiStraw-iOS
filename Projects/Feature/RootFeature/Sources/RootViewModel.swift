import Foundation
import BaseFeature

class RootViewModel: BaseViewModel {
    func pushSigninVC() {
        coordinator.navigate(to: .signinIsRequired)
    }
}
