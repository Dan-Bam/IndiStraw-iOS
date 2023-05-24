import UIKit

public class ButtonComponent: UIButton {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10
//        self.backgroundColor = DesignSystemColors.Color.mainColor.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
