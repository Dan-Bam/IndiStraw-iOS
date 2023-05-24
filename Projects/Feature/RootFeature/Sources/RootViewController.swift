import UIKit
import BaseFeature
import DesignSystem
import Utility

class RootViewController: BaseVC<RootViewModel> {
    private let logoLabel = UILabel().then {
        $0.text = "Indi Straw"
        $0.textColor = .white
        $0.font = UIFont(font: DesignSystemFontFamily.Suit.bold, size: 30)
    }
    
    private let signinButton = ButtonComponent().then {
        $0.setTitle("로그인", for: .normal)
    }
    
    override func configureVC() {
    }
    
    override func addView() {
        view.addSubviews(logoLabel, signinButton)
    }
    
    override func setLayout() {
        logoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(287)
            $0.centerX.equalToSuperview()
        }
        
        signinButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(87)
            $0.leading.trailing.equalToSuperview().inset(33)
            $0.height.equalTo(54)
        }
    }
}
