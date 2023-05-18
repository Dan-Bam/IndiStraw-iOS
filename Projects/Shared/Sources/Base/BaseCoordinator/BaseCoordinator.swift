import UIKit

public protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }
    
    func start()
    func start(coordinator: Coordinator)
    func didFinish(coordinator: Coordinator)
    func navigate(to step: IndiStrawStep)
    func removeChildCoordinators()
}

public class BaseCoordinator: Coordinator {
    public var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    public var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    
    public func start() {
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
