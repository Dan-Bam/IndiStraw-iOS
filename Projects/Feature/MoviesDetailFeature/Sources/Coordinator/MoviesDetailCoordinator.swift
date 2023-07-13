import BaseFeature

public class MoviesDetailCoordinator: BaseCoordinator {
    public func startMoviesDetailCoordinator(movieIdx: Int) {
        let vm = MoviesDetailViewModel(coordinator: self, movieIdx: movieIdx)
        let vc = MoviesDetailViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
