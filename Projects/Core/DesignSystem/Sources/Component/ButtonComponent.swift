import UIKit

public class ButtonComponent: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10
        self.backgroundColor = DesignSystemAsset.Colors.mainColor.color
        self.titleLabel?.textColor = .white
        self.titleLabel?.font = DesignSystemFontFamily.Suit.medium.font(size: 18)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    public func setLeftICon(image: UIImage) {
//        self.leftViewMode = .always
//        let wrapperView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.frame.size.height))
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 12))
//        imageView.center = CGPoint(x: self.center.x + 20, y: self.center.y)
//        imageView.image = image
//        wrapperView.addSubview(imageView)
//        self.leftView = wrapperView
//    }
}
