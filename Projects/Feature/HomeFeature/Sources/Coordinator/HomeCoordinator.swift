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
        case .crowdFundingDetailIsRequired(let idx):
            crowdFundingIsRequired(idx: idx)
        case .crowdFundingListIsRequired:
            crowdFundingListIsRequired()
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
        vc.startCrowdFundingDetailCoordinator(idx: idx)
    }
    
    func crowdFundingListIsRequired() {
        let vc = CrowdFundingCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.startCrowdFundingListCoordinator()
    }
    
    func profileIsRequired() {
        let vc = ProfileCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.start()
    }
}
