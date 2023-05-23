import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "DesignSystem",
    product: .framework,
    dependencies: [
        .SPM.SnapKit,
        .SPM.Then,
        .SPM.RxSwift,
        .SPM.RxCocoa,
        .SPM.Alamofire,
        .SPM.Swinject
    ],
    resources: ["Resources/**"]
)
