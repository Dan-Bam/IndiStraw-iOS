import ProjectDescription

extension TargetDependency{
    public struct SPM {}
}

public extension TargetDependency.SPM {
    static let SnapKit = TargetDependency.external(name: "SnapKit")
    static let Then = TargetDependency.external(name: "Then")
    static let Kingfisher = TargetDependency.external(name: "Kingfisher")
    static let RxSwift = TargetDependency.external(name: "RxSwift")
    static let RxCocoa = TargetDependency.external(name: "RxCocoa")
    static let Alamofire = TargetDependency.external(name: "Alamofire")
    static let Swinject = TargetDependency.external(name: "Swinject")
    static let RxGesture = TargetDependency.external(name: "RxGesture")
    static let ColorfulLog = TargetDependency.external(name: "ColorfulLog")
}
