import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "BaseFeature",
    product: .framework,
    dependencies: [
        .SPM.SnapKit,
        .SPM.Then
    ]
)
