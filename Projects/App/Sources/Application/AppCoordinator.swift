import UIKit
import BaseFeature
import RootFeature
import SignupFeature
import DesignSystem

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
        window?.rootViewController = navigationController
        let rootController = SignupPaswordCoordinator(navigationController: navigationController)
        
        rootController.startSignupPaswordCoordinator(id: "", name: "", phoneNumber: "", profileImage: DesignSystemAsset.Images.inputPhoto.image)
//        start(coordinator: rootController)
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
