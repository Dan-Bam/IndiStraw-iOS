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
        $0.setImage(
            DesignSystemAsset.Images.profileIcon.image
                .withConfiguration(UIImage.SymbolConfiguration(
                    pointSize: 30,
                    weight: .light
                )), for: .normal)
        $0.tintColor = .white
        $0.layer.cornerRadius = 40
    }
    
    private let userNameLabel = UILabel().then {
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.bold.font(size: 20)
    }
    
    private let segmentedControl = UISegmentedControl(items: ["최근시청", "출연작품"]).then {
        $0.selectedSegmentIndex = 0
        $0.setTitleTextAttributes([
            .foregroundColor: DesignSystemAsset.Colors.darkGray.color,
            .font: DesignSystemFontFamily.Suit.semiBold.font(size: 16)
        ], for: .normal)
        $0.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    private let underlineView = UIView().then {
        $0.backgroundColor = DesignSystemAsset.Colors.mainColor.color
        $0.layer.cornerRadius = 1
    }
    
    override func configureVC() {
        navigationItem.rightBarButtonItem = settingButton
        segmentedControl.removeBackgroundAndDidiver()
        
        underlineView.frame = segmentedControl.addSegmentedControlUnderLinde()
        segmentedControl.addSubview(underlineView)
        
        settingButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.viewModel.pushSettingVC()
            }.disposed(by: disposeBag)
        
        viewModel.requestProfileName()
            .observe(on: MainScheduler.instance)
            .bind(with: self) { owner, name in
                owner.userNameLabel.text = name + "님"
            }.disposed(by: disposeBag)
        
        segmentedControl.rx.selectedSegmentIndex.changed
            .bind(with: self) { owner, _ in
                let underlineFinalXPosition = ((self.segmentedControl.bounds.width / CGFloat(self.segmentedControl.numberOfSegments)) * CGFloat(self.segmentedControl.selectedSegmentIndex)) + 9
                UIView.animate(
                    withDuration: 0.1,
                    animations: {
                        self.underlineView.frame.origin.x = underlineFinalXPosition
                    }
                )
                switch owner.segmentedControl.selectedSegmentIndex {

                default:
                    return
                }
            }.disposed(by: disposeBag)
    }
    
    override func addView() {
        view.addSubviews(
            profileImageButton, userNameLabel,
            segmentedControl
        )
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
        
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(15)
            $0.height.equalTo(23)
        }
    }
}
