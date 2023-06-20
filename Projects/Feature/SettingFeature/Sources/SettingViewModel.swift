import Foundation
import BaseFeature

class SettingViewModel: BaseViewModel {
    func pushEditProfileVC() {
        coordinator.navigate(to: .editProfileIsRequired)
    }
}
