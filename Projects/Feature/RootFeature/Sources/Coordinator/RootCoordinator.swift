import UIKit
import BaseFeature
import SigninFeature

public class RootCoordinator: BaseCoordinator {
    public override func start() {
        let vm = RootViewModel(coordinator: self)
        let vc = RootViewController(viewModel: vm)
        
        navigationController.setViewControllers([vc], animated: true)
    }
    
    public override func navigate(to step: IndiStrawStep) {
        switch step {
        case .signinIsRequired:
            signinIsRequired()
        }
    }
}

extension RootCoordinator {
    private func signinIsRequired() {
        let vc = SigninCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.start()
    }
}
