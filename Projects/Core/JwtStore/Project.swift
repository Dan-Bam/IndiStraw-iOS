import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "JwtStore",
    product: .framework,
    dependencies: [
        .Shared.GlobalThirdPartyLib,
        .Shared.Utility
    ],
    resources: ["Resources/**"]
)
