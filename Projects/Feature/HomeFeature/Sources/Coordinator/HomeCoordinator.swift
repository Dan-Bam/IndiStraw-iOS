import Foundation
import BaseFeature
import ProfileFeature
import CrowdFundingFeature

public class HomeCoordinator: BaseCoordinator {
    public override func start() {
        let vm = HomeViewModel(coordinator: self)
        let vc = HomeViewController(viewModel: vm)
        
        navigationController.setViewControllers([vc], animated: true)
    }
    
    public override func navigate(to step: IndiStrawStep) {
        switch step {
        case .crowdFundingIsRequired(let idx):
            crowdFundingIsRequired(idx: idx)
        case .profileIsRequired:
            profileIsRequired()
        default:
            return
        }
    }
}

extension HomeCoordinator {
    func crowdFundingIsRequired(idx: Int) {
        let vc = CrowdFundingCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.startCrowdFundingCoordinator(idx: idx)
    }
    
    func profileIsRequired() {
        let vc = ProfileCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.start()
    }
}
