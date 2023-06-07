import Foundation
import BaseFeature

class SignupPhoneNumberViewModel: BaseViewModel {
    func pushProfileImageVC() {
        coordinator.navigate(to: .selectPhotoIsRequired)
    }
}
