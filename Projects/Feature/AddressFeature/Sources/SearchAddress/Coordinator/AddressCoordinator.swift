import BaseFeature

public class AddressCoordinator: BaseCoordinator {
    public override func start() {
        let vm = AddressViewModel(coordinator: self)
        let vc = AddressViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public override func navigate(to step: IndiStrawStep) {
        switch step {
        case .detailAddressisRequired(let zipCode, let roadAddrPart):
            detailAddressisRequired(zipCode: zipCode, roadAddrPart: roadAddrPart)
        default:
            return
        }
    }
}

extension AddressCoordinator {
    func detailAddressisRequired(zipCode: String, roadAddrPart: String) {
        let vc = DetailAddressCoordinator(navigationController: navigationController)
        vc.startDetailAddressCoordinator(zipCode: zipCode, roadAddrPart: roadAddrPart)
    }
}
