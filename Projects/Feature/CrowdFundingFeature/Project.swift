import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "CrowdFundingFeature",
    product: .staticLibrary,
    dependencies: [
        .Feature.BaseFeature,
        .Core.DesignSystem,
        .Domain.RouterDomain,
        .Shared.Utility,
        .Shared.GlobalThirdPartyLib
    ]
)
