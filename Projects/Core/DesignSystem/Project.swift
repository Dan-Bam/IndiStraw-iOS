import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "DesignSystem",
    product: .staticLibrary,
    dependencies: [
        .Shared.GlobalThirdPartyLib,
            .Shared.Utility
    ],
    resources: ["Resources/**"]
)
