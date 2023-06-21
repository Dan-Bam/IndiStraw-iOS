import BaseFeature
import PhoneNumberAuthFeature
import HomeFeature

public class SigninCoordinator: BaseCoordinator {
    public override func start() {
        let vm = SigninViewModel(coordinator: self)
        let vc = SigninViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public override func navigate(to step: IndiStrawStep) {
        switch step {
        case .phoneNumberAuthIsRequired(let type):
            phoneNumberAuthIsRequired(type: type)
        case .setHomeIsRequired:
            setHomeIsRequired()
        default:
            return
        }
    }
}

extension SigninCoordinator {
    func phoneNumberAuthIsRequired(type: InputPhoneNumberType) {
        let vc = InputPhoneNumberCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.startInputPhoneNumberCoordinator(type: type, title: "전화번호 입력")
    }
    
    func setHomeIsRequired() {
        let vc = HomeCoordinator(navigationController: navigationController)
        removeChildCoordinators()
        vc.start()
    }
}
