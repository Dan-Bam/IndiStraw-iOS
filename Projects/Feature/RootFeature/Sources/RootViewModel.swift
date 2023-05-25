import Foundation
import BaseFeature

class RootViewModel: BaseViewModel {
    func pushSignin() {
        coordinator.navigate(to: .signinIsRequired)
    }
}
