import Foundation
import BaseFeature

public class RootViewModel: BaseViewModel {
    func pushSigninVC() {
        coordinator.navigate(to: .signinIsRequired)
    }
    
    func pushSignupVC() {
        coordinator.navigate(to: .signupIsRequired)
    }
}
