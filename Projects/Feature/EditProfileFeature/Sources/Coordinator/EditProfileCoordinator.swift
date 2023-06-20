import BaseFeature

public class EditProfileCoordinator: BaseCoordinator {
    public override func start() {
        let vm = EditProfileViewModel(coordinator: self)
        let vc = EditProfileViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
