import BaseFeature

class SignupProfileImageViewModel: BaseViewModel {
    func presentSelectPhotoSheet() {
        coordinator.navigate(to: .selectPhotoIsRequired)
    }
}
