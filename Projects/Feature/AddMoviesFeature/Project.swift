import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "AddMoviesFeature",
    product: .staticLibrary,
    dependencies: [
        .Feature.BaseFeature,
        .Core.DesignSystem,
        .Domain.RouterDomain,
        .Shared.Utility,
        .Shared.GlobalThirdPartyLib
    ]
)
