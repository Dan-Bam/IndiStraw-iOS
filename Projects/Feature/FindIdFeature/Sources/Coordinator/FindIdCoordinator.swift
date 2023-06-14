import Foundation
import BaseFeature

public class FindIdCoordinator: BaseCoordinator {
    public func startFindIdCoordinator(phoneNumber: String) {
        let vm = FindIdViewModel(coordinator: self)
        let vc = FindIdViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public override func navigate(to step: IndiStrawStep) {
        switch step {
        case .popToRootIsRequired:
            popToRootIsRequired()
        default:
            return
        }
    }
}

extension FindIdCoordinator {
    func popToRootIsRequired() {
        navigationController.popToRootViewController(animated: true)
    }
}
