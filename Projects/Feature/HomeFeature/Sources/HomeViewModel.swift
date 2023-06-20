import Foundation
import BaseFeature

class HomeViewModel: BaseViewModel {
    func pushProfileVC() {
        coordinator.navigate(to: .profileIsRequired)
    }
}
