import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "SigninFeature",
    product: .staticLibrary,
    dependencies: [
        .Feature.BaseFeature,
        .Feature.PhoneNumberAuthFeature,
        .Feature.HomeFeature,
        
        .Core.DesignSystem,
        
        .Domain.RouterDomain,
        
        .Shared.Utility,
        .Shared.GlobalThirdPartyLib
    ]
)
