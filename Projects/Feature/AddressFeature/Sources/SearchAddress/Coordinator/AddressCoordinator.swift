import BaseFeature

public class AddressCoordinator: BaseCoordinator {
    public override func start() {
        let vm = AddressViewModel(coordinator: self)
        let vc = AddressViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public override func navigate(to step: IndiStrawStep) {
        switch step {
        case .detailAddressisRequired(let data):
            detailAddressisRequired(data: data)
        default:
            return
        }
    }
}

extension AddressCoordinator {
    func detailAddressisRequired(data: Juso) {
        let vc = DetailAddressCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.startDetailAddressCoordinator(data: data)
    }
}
