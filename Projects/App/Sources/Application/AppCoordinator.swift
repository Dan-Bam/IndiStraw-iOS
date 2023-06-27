import UIKit
import AuthDomain
import Alamofire
import JwtStore
import BaseFeature
import RootFeature
import ProfileFeature
import HomeFeature
import MoviesDetailFeature

open class AppCoordinator: Coordinator {
    public var navigationController: UINavigationController
    public var childCoordinator: [Coordinator] = []
    public var parentCoordinator: Coordinator?
    let window: UIWindow?
    
    public init(navigationCotroller: UINavigationController, window: UIWindow?) {
        self.window = window
        self.navigationController = navigationCotroller
        window?.makeKeyAndVisible()
    }
    
    public func start() {
        let url = APIConstants.reissueURL
        let container = DIContainer.shared.resolve(JwtStore.self)!
        let headers: HTTPHeaders = ["refreshToken" : "Bearer " + container.getToken(type: .refreshToken)]
        
        let rootCoordinator = RootCoordinator(navigationController: navigationController)
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        window?.rootViewController = navigationController
        start(coordinator: MoviesDetailCoordinator(navigationController: navigationController))
//        AF.request(url,
//                   method: .patch,
//                   encoding: JSONEncoding.default,
//                   headers: headers)
//        .validate()
//        .responseDecodable(of: ManageTokenModel.self) { [weak self] response in
//            switch response.result {
//            case .success(let data):
//                container.saveToken(type: .refreshToken, token: data.refreshToken)
//                self?.start(coordinator: homeCoordinator)
//            case .failure(let error):
//                print(error.localizedDescription)
//                self?.start(coordinator: rootCoordinator)
//            }
//        }
    }
    
    public func start(coordinator: Coordinator) {
        coordinator.start()
    }
    
    public func didFinish(coordinator: Coordinator) {
        
    }
    
    public func navigate(to step: IndiStrawStep) {
        
    }
    
    public func removeChildCoordinators() {
        
    }
}
