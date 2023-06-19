import BaseFeature

class SettingCoordinator: BaseCoordinator {
    override func start() {
        let vm = SettingViewModel(coordinator: self)
        let vc = SettingViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
