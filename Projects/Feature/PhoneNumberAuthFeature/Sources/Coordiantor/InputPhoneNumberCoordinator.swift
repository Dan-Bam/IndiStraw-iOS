import Foundation
import BaseFeature
import FindIdFeature
import FindPasswordFeature

public class InputPhoneNumberCoordinator: BaseCoordinator {
    public func startInputPhoneNumberCoordinator(type: FindAccountType) {
        let vm = InputPhoneNumberViewModel(coordinator: self)
        let vc = InputPhoneNumberViewController(viewModel: vm, type: type)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public override func navigate(to step: IndiStrawStep) {
        switch step {
        case .changePasswordIsRequired(let phoneNumber):
            changePasswordIsRequired(phoneNumber: phoneNumber)
        default:
            return
        }
    }
}

extension InputPhoneNumberCoordinator {
    func changePasswordIsRequired(phoneNumber: String) {
        let vc = ChangePasswordCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.startChangePasswordCoordinator(phoneNumber: phoneNumber)
    }
}
