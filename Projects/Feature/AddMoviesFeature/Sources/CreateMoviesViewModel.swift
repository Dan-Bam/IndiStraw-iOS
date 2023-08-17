import BaseFeature
import Alamofire
import JwtStore
import RxSwift
import RxCocoa

class CreateMoviesViewModel: BaseViewModel {
    var container = DIContainer.shared.resolve(JwtStore.self)!
    
    func requestToCreateMovie(body: CreateMoviesModel) {
        
    }
}
