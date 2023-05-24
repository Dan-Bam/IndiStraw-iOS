import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "GlobalThirdPartyLib",
    product: .staticLibrary,
    dependencies: [
        .SPM.SnapKit,
        .SPM.Then,
        .SPM.RxSwift,
        .SPM.RxCocoa,
        .SPM.Alamofire,
        .SPM.Swinject
    ]
)
