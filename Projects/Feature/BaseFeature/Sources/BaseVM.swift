import Foundation

public class BaseViewModel {
    let coordinator: BaseCoordinator
    
    init(coordinator: BaseCoordinator){
        self.coordinator = coordinator
    }
}
