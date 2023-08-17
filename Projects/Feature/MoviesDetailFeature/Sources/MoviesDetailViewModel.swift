import BaseFeature

public class MoviesDetailViewModel: BaseViewModel {
    
    var movieIdx: Int
    
    public init(coordinator: Coordinator, movieIdx: Int) {
        self.movieIdx = movieIdx
        super.init(coordinator: coordinator)
    }
}
