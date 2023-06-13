import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "RootFeature",
    product: .staticLibrary,
    dependencies: [
        .Feature.BaseFeature,
        .Feature.SigninFeature,
        .Feature.SignupFeature,
        .Core.DesignSystem,
        .Shared.Utility,
        .Shared.GlobalThirdPartyLib
    ]
)
