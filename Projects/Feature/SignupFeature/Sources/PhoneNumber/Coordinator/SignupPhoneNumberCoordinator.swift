import Foundation
import BaseFeature

class SignupPhoneNumberCoordinator: BaseCoordinator {
    func startSignupPhoneNumberVC(name: String) {
        let vm = SignupPhoneNumberViewModel(coordinator: self)
        let vc = SignupPhoneNumberViewController(viewModel: vm, name: name)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    override func navigate(to step: IndiStrawStep) {
        switch step {
        case .selectPhotoIsRequired:
            selectPhotoIsRequired()
        default:
            return
        }
    }
}

extension SignupPhoneNumberCoordinator {
    func selectPhotoIsRequired() {
        let vc = SignupProfileImageCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.start()
    }
}
