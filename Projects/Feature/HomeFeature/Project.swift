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
        .Feature.AddMoviesFeature,
        
        .Core.DesignSystem,
        .Domain.RouterDomain,
        .Shared.Utility,
        .Shared.GlobalThirdPartyLib
    ]
)
