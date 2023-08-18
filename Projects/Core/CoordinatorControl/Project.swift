import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "CoordinatorControl",
    product: .framework,
    dependencies: [
        .Feature.RootFeature,
        .Feature.SigninFeature,
        .Feature.SignupFeature,
        .Feature.FindPasswordFeature,
        .Feature.FindIdFeature,
        .Feature.PhoneNumberAuthFeature,
        .Feature.HomeFeature,
        .Feature.ProfileFeature,
        .Feature.SettingFeature,
        .Feature.EditProfileFeature,
        .Feature.SelectPhotoFeature,
        .Feature.AddressFeature,
        .Feature.AddMoviesFeature,
        .Feature.MoviesDetailFeature,
        .Feature.CrowdFundingFeature,
        
        .Shared.GlobalThirdPartyLib,
        .Shared.Utility
    ],
    resources: ["Resources/**"]
)
