import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "SignupFeature",
    product: .staticLibrary,
    dependencies: [
        .Feature.BaseFeature,
        .Feature.SelectPhotoFeature,
        
        .Core.DesignSystem,
        .Domain.RouterDomain,
        .Shared.Utility,
        .Shared.GlobalThirdPartyLib
    ]
)
