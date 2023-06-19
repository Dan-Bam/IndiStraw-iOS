import UIKit
import BaseFeature
import DesignSystem
import Utility
import SnapKit
import Then

enum customButonType {
    static let editProfile = "프로필 수정"
    static let editPassword = "비밀번호 변경"
    static let editLanguage = "언어 변경"
    static let logout = "로그아웃"
    static let withdrawal = "회원탈퇴"
}

class SettingViewController: BaseVC<SettingViewModel> {
    private let editProfileButton = CustomSettingButton().then {
        $0.configure(type: customButonType.editProfile)
    }
    
    private let settingAccountLabel = UILabel().then {
        $0.text = "계정설정"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 14)
    }
    
    private let editPasswordButton = CustomSettingButton().then {
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.configure(type: customButonType.editPassword)
    }
    
    private let editLanguageButton = CustomSettingButton().then {
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.configure(type: customButonType.editLanguage)
    }
    
    private let logoutButton = CustomSettingButton().then {
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.configure(type: customButonType.logout)
    }
    
    private let withdrawalButton = CustomSettingButton().then {
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.configure(type: customButonType.withdrawal)
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


extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            default:
                break
            }
        }
    }
}
