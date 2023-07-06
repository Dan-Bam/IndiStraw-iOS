import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "ProfileFeature",
    product: .staticLibrary,
    dependencies: [
        .Feature.BaseFeature,
        .Feature.SettingFeature,
        .Core.DesignSystem,
        .Domain.RouterDomain,
        .Shared.Utility,
        .Shared.GlobalThirdPartyLib
    ]
)
