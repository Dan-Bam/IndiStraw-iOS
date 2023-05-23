import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "SigninFeature",
    product: .staticLibrary,
    dependencies: [
        .Feature.BaseFeature,
        .SPM.SnapKit,
        .SPM.Then,
        .SPM.RxSwift,
        .SPM.RxCocoa,
        .SPM.Alamofire,
        .SPM.Swinject
    ]
)
