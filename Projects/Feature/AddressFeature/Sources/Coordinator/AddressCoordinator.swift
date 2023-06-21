import BaseFeature

class AddressCoordinator: BaseCoordinator {
    override func start() {
        let vm = AddressViewModel(coordinator: self)
        let vc = AddressViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
