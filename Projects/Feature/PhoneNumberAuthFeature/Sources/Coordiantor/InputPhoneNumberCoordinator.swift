import Foundation
import BaseFeature
import FindIdFeature
import FindPasswordFeature

public class InputPhoneNumberCoordinator: BaseCoordinator {
    public override func start() {
        let vm = InputPhoneNumberViewModel(coordinator: self)
        let vc = InputPhoneNumberViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public override func navigate(to step: IndiStrawStep) {
        switch step {
        case .findPassword_changePassword(let phoneNumber):
            findPassword_changePassword(phoneNumber: phoneNumber)
        default:
            return
        }
    }
}

extension InputPhoneNumberCoordinator {
    func findPassword_changePassword(phoneNumber: String) {
        let vc = ChangePasswordCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.startChangePasswordCoordinator(phoneNumber: phoneNumber)
    }
}
