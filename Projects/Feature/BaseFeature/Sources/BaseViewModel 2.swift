import Foundation

open class BaseViewModel {
    public let coordinator: Coordinator
    
    public init(coordinator: Coordinator){
        self.coordinator = coordinator
    }
}
