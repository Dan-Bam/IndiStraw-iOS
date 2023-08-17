import UIKit
import BaseFeature
import AddressFeature

public class DetailAddressCoordinator: BaseCoordinator {
    func startDetailAddressCoordinator(zipCode: String, roadAddrPart: String) {
        let vm = DetailAddressViewModel(coordinator: self)
        let vc = DetailAddressViewController(viewModel: vm, zipCode: zipCode, roadAddrPart: roadAddrPart)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public override func navigate(to step: IndiStrawStep) {
        switch step {
        case .popViewIsRequired:
            popViewIsRequired()
        default:
            return
        }
    }
}

extension DetailAddressCoordinator {
    func popViewIsRequired() {
        let viewControllers: [UIViewController] = navigationController.viewControllers as [UIViewController]
        navigationController.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
}
