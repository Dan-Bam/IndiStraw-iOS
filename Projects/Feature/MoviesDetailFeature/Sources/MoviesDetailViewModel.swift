import BaseFeature

class MoviesDetailViewModel: BaseViewModel {
    
    var movieIdx: Int
    
    init(coordinator: Coordinator, movieIdx: Int) {
        self.movieIdx = movieIdx
        super.init(coordinator: coordinator)
    }
}
