import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "AssemblyDomain",
    product: .staticLibrary,
    dependencies: [
        .Feature.SigninFeature,
        .Shared.GlobalThirdPartyLib
    ]
)
