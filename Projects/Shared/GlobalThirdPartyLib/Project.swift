import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "GlobalThirdPartyLib",
    product: .framework,
    dependencies: [
        .SPM.SnapKit,
        .SPM.Then,
        .SPM.RxSwift,
        .SPM.RxCocoa,
        .SPM.Alamofire,
        .SPM.Swinject,
        .SPM.RxGesture,
        .SPM.Kingfisher,
        .SPM.ColorfulLog
    ]
)
