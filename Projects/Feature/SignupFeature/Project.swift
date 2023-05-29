import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "SignupFeature",
    product: .staticLibrary,
    dependencies: [
        .Feature.BaseFeature,
        .Core.DesignSystem,
        .Shared.Utility,
        .Shared.GlobalThirdPartyLib
    ]
)
