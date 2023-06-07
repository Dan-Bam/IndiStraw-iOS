import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "RootFeature",
    product: .staticLibrary,
    dependencies: [
        .Feature.BaseFeature,
        .Feature.SigninFeature,
        .Core.DesignSystem,
        .Shared.Utility,
        .Shared.GlobalThirdPartyLib
    ]
)
