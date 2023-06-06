import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "JwtStore",
    product: .framework,
    dependencies: [
        .Shared.GlobalThirdPartyLib
    ],
    resources: ["Resources/**"]
)
