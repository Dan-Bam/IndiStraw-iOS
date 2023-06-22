import BaseFeature

class DetailAddressCoordinator: BaseCoordinator {
    override func start() {
        let vm = DetailAddressViewModel(coordinator: self)
        let vc = DetailAddressViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
