import UIKit
import BaseFeature
import DesignSystem
import SnapKit
import Then
import RxSwift
import RxCocoa

class ProfileViewController: BaseVC<ProfileViewModel> {
    private let disposeBag = DisposeBag()
    
    private let settingButton = UIBarButtonItem().then {
        $0.tintColor = .white
        $0.image = UIImage(systemName: "gearshape")
    }
    
    private let profileImageButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).then {
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = false
        $0.isEnabled = true
        $0.backgroundColor = DesignSystemAsset.Colors.gray.color
        $0.setImage(DesignSystemAsset.Images.profileIcon.image.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .light)), for: .normal)
//        $0.setImage(UIImage(systemName: "person", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light)), for: .normal)
        $0.tintColor = .white
        $0.layer.cornerRadius = 40
    }
    
    private let userNameLabel = UILabel().then {
        $0.text = "민도현님"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.bold.font(size: 20)
    }
    
    override func configureVC() {
        navigationItem.rightBarButtonItem = settingButton
        
        settingButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.viewModel.pushSettingVC()
            }.disposed(by: disposeBag)
    }
    
    override func addView() {
        view.addSubviews(profileImageButton, userNameLabel)
    }
    
    override func setLayout() {
        profileImageButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(17)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(80)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageButton.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
        }
    }
}
