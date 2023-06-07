import Foundation

public protocol RemoteAuthDataSource {
    func signin(req: SigninRequest)
}
