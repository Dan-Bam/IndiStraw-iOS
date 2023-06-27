import BaseFeature

class AddMoviesCoordinator: BaseCoordinator {
    override func start() {
        let vm = AddMoviesViewModel(coordinator: self)
        let vc = AddMoviesViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
