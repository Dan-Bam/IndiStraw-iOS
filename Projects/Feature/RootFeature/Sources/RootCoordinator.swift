import UIKit
import BaseFeature

open class RootCoordinator: Coordinator {
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
        let vm = RootViewModel(coordinator: self)
        let rootController = RootViewController(viewModel: vm)
        navigationController.setViewControllers([rootController], animated: true)
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
