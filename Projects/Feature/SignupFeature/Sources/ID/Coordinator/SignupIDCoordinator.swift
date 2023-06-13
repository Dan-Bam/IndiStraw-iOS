import UIKit
import BaseFeature

class SignupIDCoordiantor: BaseCoordinator {
    func startSignupIDCoordiantor(image: UIImage?, name: String, phoneNumber: String) {
        let vm = SignupIDViewModel(coordinator: self, image: image, name: name, phoneNumber: phoneNumber)
        let vc = SignupIDViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    override func navigate(to step: IndiStrawStep) {
        switch step {
        case .inputPasswordIsRequired(let id, let name, let phoneNumber, let profileImage):
            inputPasswordIsRequired(id: id, name: name, phoneNumber: phoneNumber, profileImage: profileImage)
        default:
            return
        }
    }
}

extension SignupIDCoordiantor {
    func inputPasswordIsRequired(id: String, name: String, phoneNumber: String, profileImage: UIImage?) {
        let vc = SignupPaswordCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.startSignupPaswordCoordinator(id: id, name: name, phoneNumber: phoneNumber, profileImage: profileImage)
    }
}
