import BaseFeature
import AddMoviesFeature

public class CreateMoviesCoordinator: BaseCoordinator {
    public override func start() {
        let vm = CreateMoviesViewModel(coordinator: self)
        let vc = CreateMoviesViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
