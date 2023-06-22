import Foundation
import BaseFeature

class SettingViewModel: BaseViewModel {
    func pushEditProfileVC() {
        coordinator.navigate(to: .editProfileIsRequired)
    }
    
    func pushChangePassword() {
        coordinator.navigate(to: .phoneNumberAuthIsRequired(type: .changePassword))
    }
}
