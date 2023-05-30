import UIKit
import BaseFeature

public class SignupProfileImageCoordinator: BaseCoordinator {
    public override func start() {
        let vm = SignupProfileImageViewModel(coordinator: self)
        let vc = SignupProfileImageViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public override func navigate(to step: IndiStrawStep) {
        switch step {
        case .selectPhotoIsRequired:
            selectPhotoIsRequired()
        default:
            return
        }
    }
}

extension SignupProfileImageCoordinator {
    func selectPhotoIsRequired() {
        let vc = SelectPhotoBottomSheet()
        vc.modalPresentationStyle = .pageSheet
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        navigationController.present(vc, animated: true)
    }
}
