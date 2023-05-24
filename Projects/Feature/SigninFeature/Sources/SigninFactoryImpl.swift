import Foundation
import BaseFeature

public protocol SigninFactory {
    func makeCoordinator() -> BaseCoordinator
}

//struct SigninFactoryImpl: SigninFactory {
//    func makeCoordinator() -> BaseFeature.BaseCoordinator {
//        return BaseCoordinator
//    }
    
//    func makeCoordinator() -> BaseCoordinator {
//        let vm = SigninViewModel(coordinator: self)
//        return SigninCoordinator(signinViewController: SigninViewController(coder: <#NSCoder#>), signinFactory: SigninFactory())
//    }
//}
