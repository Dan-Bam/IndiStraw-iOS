import Foundation
import BaseFeature

class ProfileViewModel: BaseViewModel {
    func pushSettingVC() {
        coordinator.navigate(to: .settingIsRequired)
    }
}
