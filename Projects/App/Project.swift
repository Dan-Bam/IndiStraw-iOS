import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: Environment.appName,
    platform: .iOS,
    product: .app,
    dependencies: [
        
        TargetDependency.project(
            target: "DesignSystem",
            path: .relativeToRoot("Projects/Core/DesignSystem")),
        TargetDependency.project(
            target: "BaseFeature",
            path: .relativeToRoot("Projects/Feature/BaseFeature")),
        TargetDependency.project(
            target: "SigninFeature",
            path: .relativeToRoot("Projects/Feature/SigninFeature"))
        
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist")
)
