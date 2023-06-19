import UIKit
import BaseFeature

class ProfileViewController: BaseVC<ProfileViewModel> {
    private let settingButton = UIBarButtonItem().then {
        $0.tintColor = .white
        $0.image = UIImage(systemName: "gearshape")
    }
    
    override func configureVC() {
        navigationItem.rightBarButtonItem = settingButton
    }
}
