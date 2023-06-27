import BaseFeature

public class MoviesDetailCoordinator: BaseCoordinator {
    public override func start() {
        let vm = MoviesDetailViewModel(coordinator: self)
        let vc = MoviesDetailViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
