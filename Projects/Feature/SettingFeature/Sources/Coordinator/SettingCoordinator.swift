import BaseFeature
import EditProfileFeature

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
}
