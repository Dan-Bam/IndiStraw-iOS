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
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 14)
        $0.text = "계정설정"
    }
    
    private let editPasswordButton = CustomSettingButton().then {
        $0.setText(text: "비밀번호 변경")
    }
    
    private let editLanguageButton = CustomSettingButton().then {
        $0.setText(text: "언어 변경")
    }
    
    private let logoutBUtton = CustomSettingButton().then {
        $0.setText(text: "로그아웃")
    }
    
    private let withdrawalButton = CustomSettingButton().then {
        $0.setText(text: "로그아웃")
    }
    
    override func configureVC() {
        
    }
    
    override func addView() {
        view.addSubviews(
            editProfileButton, settingAccountLabel,
            editPasswordButton, editLanguageButton,
            logoutBUtton, withdrawalButton)
    }
    
    override func setLayout() {
        editProfileButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(60)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(54)
        }
        
        settingAccountLabel.snp.makeConstraints {
            $0.top.equalTo(editProfileButton.snp.bottom).inset(36)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(54)
        }
        
        editPasswordButton.snp.makeConstraints {
            $0.top.equalTo(settingAccountLabel.snp.bottom).inset(10)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(54)
        }
        
        editLanguageButton.snp.makeConstraints {
            $0.top.equalTo(editPasswordButton.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(54)
        }
        
        logoutBUtton.snp.makeConstraints {
            $0.top.equalTo(editLanguageButton.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(54)
        }
        
        editProfileButton.snp.makeConstraints {
            $0.top.equalTo(logoutBUtton.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(54)
        }
    }
}
