import Foundation

open class BaseViewModel {
    let coordinator: BaseCoordinator
    
    init(coordinator: BaseCoordinator){
        self.coordinator = coordinator
    }
}
