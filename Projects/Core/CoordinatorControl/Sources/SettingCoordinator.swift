import BaseFeature
import EditProfileFeature
import PhoneNumberAuthFeature
import SettingFeature

public class SettingCoordinator: BaseCoordinator {
    public override func start() {
        let vm = SettingViewModel(coordinator: self)
        let vc = SettingViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public override func navigate(to step: IndiStrawStep) {
        switch step {
        case .editProfileIsRequired:
            editProfileIsRequired()
        case .phoneNumberAuthIsRequired(let type):
            phoneNumberAuthIsRequired(type: type)
        default:
            return
        }
    }
}

extension SettingCoordinator {
    func editProfileIsRequired() {
        let vc = EditProfileCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.start()
    }
    
    func phoneNumberAuthIsRequired(type: InputPhoneNumberType) {
        let vc = InputPhoneNumberCoordinator(navigationController: navigationController)
        vc.startInputPhoneNumberCoordinator(type: type, title: "전화번호 변경")
    }
}
