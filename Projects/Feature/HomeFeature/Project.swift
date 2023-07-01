import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "HomeFeature",
    product: .staticLibrary,
    dependencies: [
        .Feature.BaseFeature,
        .Feature.ProfileFeature,
        .Feature.MoviesDetailFeature,
        .Feature.CrowdFundingFeature,
        
        .Core.DesignSystem,
        .Domain.AuthDomain,
        .Shared.Utility,
        .Shared.GlobalThirdPartyLib
    ]
)
