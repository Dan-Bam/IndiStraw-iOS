import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "RouterDomain",
    product: .staticLibrary,
    dependencies: [
        .Core.JwtStore,
        .Shared.GlobalThirdPartyLib
    ]
)
