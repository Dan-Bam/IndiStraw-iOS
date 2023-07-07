import UIKit
import Swinject
import JwtStore

@main
public class AppDelegate: UIResponder, UIApplicationDelegate {
    var assembler: Assembler!

    public func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        assembler = Assembler([
            JwtStoreAssembly()
        ], container: DIContainer.shared)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    public func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    public func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {}
}
