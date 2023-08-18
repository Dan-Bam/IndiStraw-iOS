import Foundation
import BaseFeature
import FindPasswordFeature

public class ChangePasswordCoordinator: BaseCoordinator {
    public func startChangePasswordCoordinator(phoneNumber: String) {
        let vm = ChangePasswordViewModel(coordinator: self, phoneNumber: phoneNumber)
        let vc = ChangePasswordViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public override func navigate(to step: IndiStrawStep) {
        switch step {
        case .popToRootIsRequired:
            popToRootIsRequired()
        default:
            return
        }
    }
}

extension ChangePasswordCoordinator {
    func popToRootIsRequired() {
        navigationController.popToRootViewController(animated: true)
    }
}
