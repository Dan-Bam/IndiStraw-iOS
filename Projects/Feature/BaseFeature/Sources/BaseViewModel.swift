import Foundation

open class BaseViewModel {
    let coordinator: Coordinator
    
    public init(coordinator: Coordinator){
        self.coordinator = coordinator
    }
}
