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
    
    override func configureVC() {
    }
    
    override func addView() {
        view.addSubviews(logoLabel)
    }
    
    override func setLayout() {
        logoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(287)
            $0.centerX.equalToSuperview()
        }
    }
}
