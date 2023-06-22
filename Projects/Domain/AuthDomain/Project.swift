import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "AuthDomain",
    product: .staticLibrary,
    dependencies: [
        .Core.JwtStore,
        .Shared.GlobalThirdPartyLib
    ]
)
