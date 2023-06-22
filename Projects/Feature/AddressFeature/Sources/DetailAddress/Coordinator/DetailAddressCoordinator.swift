import BaseFeature

class DetailAddressCoordinator: BaseCoordinator {
    override func startDetailAddressCoordinator(data: Juso) {
        let vm = DetailAddressViewModel(coordinator: self)
        let vc = DetailAddressViewController(viewModel: vm, data: data)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
