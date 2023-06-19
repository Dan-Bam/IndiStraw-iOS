import UIKit
import BaseFeature
import DesignSystem

class ProfileViewController: BaseVC<ProfileViewModel> {
    private let settingButton = UIBarButtonItem().then {
        $0.tintColor = .white
        $0.image = UIImage(systemName: "gearshape")
    }
    
    private let profileImageButton = UIButton().then {
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = false
        $0.isEnabled = true
        $0.backgroundColor = DesignSystemAsset.Colors.exampleText.color
        $0.setImage(DesignSystemAsset.Images.inputPhoto.image, for: .normal)
        $0.imageEdgeInsets = UIEdgeInsets(top: 22, left: 22, bottom: 22, right: 22)
        $0.layer.cornerRadius = 40
    }
    override func configureVC() {
        navigationItem.rightBarButtonItem = settingButton
    }
    
    override func addView() {
        view.addSubviews(profileImageButton)
    }
    
    override func setLayout() {
        profileImageButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(22)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(80)
        }
    }
}
