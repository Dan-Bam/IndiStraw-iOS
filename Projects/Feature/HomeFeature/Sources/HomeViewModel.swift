import Foundation
import BaseFeature
import Alamofire
import JwtStore
import RxSwift
import RxCocoa

public class HomeViewModel: BaseViewModel {
    let container = DIContainer.shared.resolve(JwtStore.self)!
    var crowdFundingCurrentPage = 0
    var historyMoviesCurrentPage = 0
    
    var fundingData = BehaviorRelay<[FundingList]>(value: [])
    var popularMoviesData = BehaviorRelay<[PopularAndRecommendMoviesModel]>(value: [])
    var recommendMoviesData = BehaviorRelay<[PopularAndRecommendMoviesModel]>(value: [])
    var watchHistoryMoviesData = BehaviorRelay<[MovieList]>(value: [])
    
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
    
    func requestRecommendMoviesList() {
        AF.request(HomeTarget.requestToRecommendMoviesList,
                   interceptor: JwtRequestInterceptor(jwtStore: container))
        .validate()
        .responseDecodable(of: [PopularAndRecommendMoviesModel].self) { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.recommendMoviesData.accept(data)
            case .failure(let error):
                print("Error - PopularMovies = \(error.localizedDescription)")
            }
        }
    }
    
    func requestWatchHistoryMoviesList() {
        AF.request(HomeTarget.reqeustToWatchHistoryMoviesList(MovieListRequestModel(page: historyMoviesCurrentPage + 1)),
                   interceptor: JwtRequestInterceptor(jwtStore: container))
        .validate()
        .responseDecodable(of: MovieListResponseModel.self) { [weak self] response in
            switch response.result {
            case .success(let data):
                print(data)
                self?.watchHistoryMoviesData.accept(data.list)
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
    
    func pushCreateMovieVC() {
        coordinator.navigate(to: .createMovieVCIsReuiqred)
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
