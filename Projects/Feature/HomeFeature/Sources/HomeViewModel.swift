import Foundation
import BaseFeature
import Alamofire
import JwtStore
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    let container = DIContainer.shared.resolve(JwtStore.self)!
    var crowdFundingCurrentPage = 0
    
    var fundingData = BehaviorRelay<[FundingList]>(value: [])
    var popularMoviesData = BehaviorRelay<[PopularAndRecommendMoviesModel]>(value: [])
    var recommendMoviesData = BehaviorRelay<[PopularAndRecommendMoviesModel]>(value: [])
    var watchHistoryMoviesData = BehaviorRelay<[WatchHistorydMoviesModel]>(value: [])
    
    func requestPopularMoviesList() {
        AF.request(HomeTarget.requestPopularMoviesList,
                   interceptor: JwtRequestInterceptor(jwtStore: container))
        .validate()
        .responseDecodable(of: [PopularAndRecommendMoviesModel].self) { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.popularMoviesData.accept(data)
            case .failure(let error):
                print("Error - PopularMovies = \(error.localizedDescription)")
            }
        }
    }
    
    func requestCrowdFundingList() {
        AF.request(HomeTarget.requestCrowdFundingList,
                   interceptor: JwtRequestInterceptor(jwtStore: container))
        .validate()
        .responseDecodable(of: [FundingList].self) { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.fundingData.accept(data)
            case .failure(let error):
                print("Popular CrowdFunding List - error = \(error.localizedDescription)")
            }
        }
    }
    
    func pushMovieDetailVC(idx: Int) {
        coordinator.navigate(to: .movieDetailIsRequired(idx: idx))
    }
    
    func pushCrowdFundingDetailVC(idx: Int) {
        coordinator.navigate(to: .crowdFundingDetailIsRequired(idx: idx))
    }
    
    func pushCrowdFundingListVC() {
        coordinator.navigate(to: .crowdFundingListIsRequired)
    }
    
    func pushProfileVC() {
        coordinator.navigate(to: .profileIsRequired)
    }
}
