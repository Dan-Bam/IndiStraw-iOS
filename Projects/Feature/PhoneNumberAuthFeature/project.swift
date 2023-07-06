import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "PhoneNumberAuthFeature",
    product: .staticLibrary,
    dependencies: [
        .Feature.BaseFeature,
        .Feature.FindIdFeature,
        .Feature.FindPasswordFeature,
        
        .Core.DesignSystem,
        
        .Domain.RouterDomain,
        
        .Shared.Utility,
        .Shared.GlobalThirdPartyLib
    ]
)
