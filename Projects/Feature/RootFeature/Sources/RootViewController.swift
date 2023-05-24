import UIKit
import BaseFeature
import DesignSystem

class RootViewController: BaseVC<RootViewModel> {
    private let logoLabel = UILabel().then {
        $0.text = "Indi Straw"
        $0.font = UIFont(font: DesignSystemFontFamily.Suit.bold, size: 30)
    }
    
    override func configureVC() {
        view.backgroundColor = .black
    }
    
    override func addView() {
    }
    
    override func setLayout() {
        
    }
}
