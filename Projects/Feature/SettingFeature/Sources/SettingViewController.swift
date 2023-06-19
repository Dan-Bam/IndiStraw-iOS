import UIKit
import BaseFeature
import DesignSystem
import Utility
import SnapKit
import Then

class SettingViewController: BaseVC<SettingViewModel> {
    private let editProfileButton = CustomSettingButton().then {
        $0.setText(text: "프로필 수정")
    }
    
    private let settingAccountLabel = UILabel().then {
        $0.text = "계정설정"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 14)
    }
    
    private let editPasswordButton = CustomSettingButton().then {
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.setText(text: "비밀번호 변경")
    }
    
    private let editLanguageButton = CustomSettingButton().then {
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.setText(text: "언어 변경")
    }
    
    private let logoutButton = CustomSettingButton().then {
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.setText(text: "로그아웃")
    }
    
    private let withdrawalButton = CustomSettingButton().then {
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.setText(text: "회원탈퇴")
    }
    
    override func configureVC() {
        
    }
    
    override func addView() {
        view.addSubviews(
            editProfileButton, settingAccountLabel,
            editPasswordButton, editLanguageButton,
            logoutButton, withdrawalButton)
    }
    
    override func setLayout() {
        editProfileButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(149)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(57)
        }
        
        settingAccountLabel.snp.makeConstraints {
            $0.top.equalTo(editProfileButton.snp.bottom).offset(36)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(57)
        }
        
        editPasswordButton.snp.makeConstraints {
            $0.top.equalTo(settingAccountLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(57)
        }

        editLanguageButton.snp.makeConstraints {
            $0.top.equalTo(editPasswordButton.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(57)
        }

        logoutButton.snp.makeConstraints {
            $0.top.equalTo(editLanguageButton.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(57)
        }

        withdrawalButton.snp.makeConstraints {
            $0.top.equalTo(logoutButton.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(57)
        }
    }
}
