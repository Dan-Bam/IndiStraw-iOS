import Foundation

public class BaseViewModel {
    public let coordinator: BaseCoordinator
    
    init(coordinator: BaseCoordinator){
        self.coordinator = coordinator
    }
}
