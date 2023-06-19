import BaseFeature
import SettingFeature

public class ProfileCoordinator: BaseCoordinator {
    public override func start() {
        let vm = ProfileViewModel(coordinator: self)
        let vc = ProfileViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public override func navigate(to step: IndiStrawStep) {
        switch step {
        case .settingIsRequired:
            settingIsRequired()
        default:
            return
        }
    }
}

extension ProfileCoordinator {
    func settingIsRequired() {
        let vc = SettingCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.start()
    }
}
