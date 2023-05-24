import Foundation

open class BaseViewModel {
    let coordinator: BaseCoordinator
    
    public init(coordinator: BaseCoordinator){
        self.coordinator = coordinator
    }
}
