import UIKit
import BaseFeature
import DesignSystem
import Utility

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
        
    }
}
