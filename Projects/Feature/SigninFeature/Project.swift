import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "SigninFeature",
    product: .staticLibrary,
    dependencies: [
        .Feature.BaseFeature,
        .Feature.FindIdFeature,
        .Feature.FindPasswordFeature,
        
        .Core.DesignSystem,
        
        .Domain.AuthDomain,
        
        .Shared.Utility,
        .Shared.GlobalThirdPartyLib
    ]
)
