import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "EditProfileFeature",
    product: .staticLibrary,
    dependencies: [
        .Feature.BaseFeature,
        .Core.DesignSystem,
        .Domain.AuthDomain,
        .Shared.Utility,
        .Shared.GlobalThirdPartyLib
    ]
)
