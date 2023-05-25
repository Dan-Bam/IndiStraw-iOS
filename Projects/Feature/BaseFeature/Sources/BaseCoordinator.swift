import UIKit

open class BaseCoordinator: Coordinator {
    public var navigationController: UINavigationController
    public var childCoordinators = [Coordinator]()
    public var parentCoordinator: Coordinator?
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    
    open func start() {
        fatalError("Start method should be implemented")
    }
    
    public func start(coordinator: Coordinator) {
        childCoordinators += [coordinator]
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    public func didFinish(coordinator: Coordinator) {
        if let idx = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: idx)
        }
    }
    
    public func navigate(to step: IndiStrawStep){
        
    }
    
    public func removeChildCoordinators() {
        childCoordinators.forEach{ $0.removeChildCoordinators() }
        childCoordinators.removeAll()
    }
}
