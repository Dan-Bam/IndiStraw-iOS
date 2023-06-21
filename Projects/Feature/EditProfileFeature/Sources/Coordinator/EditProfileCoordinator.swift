import BaseFeature
import PhoneNumberAuthFeature

public class EditProfileCoordinator: BaseCoordinator {
    public override func start() {
        let vm = EditProfileViewModel(coordinator: self)
        let vc = EditProfileViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public override func navigate(to step: IndiStrawStep) {
        switch step {
        case .changePhoneNumberIsRequired:
            changePhoneNumberIsRequired()
        default:
            return
        }
    }
}

extension EditProfileCoordinator {
    func changePhoneNumberIsRequired() {
        let vc = InputPhoneNumberCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.startInputPhoneNumberCoordinator(type: .changePhoneNumber, title: "새로운 전화번호 입력")
    }
}
