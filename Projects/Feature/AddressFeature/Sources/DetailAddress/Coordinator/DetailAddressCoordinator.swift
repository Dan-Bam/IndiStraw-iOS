import Foundation
import BaseFeature

class DetailAddressCoordinator: BaseCoordinator {
    func startDetailAddressCoordinator(zipCode: String, roadAddrPart: String) {
        let vm = DetailAddressViewModel(coordinator: self)
        let vc = DetailAddressViewController(viewModel: vm, zipCode: zipCode, roadAddrPart: roadAddrPart)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
