import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "RootFeature",
    product: .staticLibrary,
    dependencies: [
        .Feature.BaseFeature,
        .Shared.GlobalThirdPartyLib
    ]
)
