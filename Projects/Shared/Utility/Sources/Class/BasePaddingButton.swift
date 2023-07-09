import UIKit

public class BasePaddingButton: UIButton {
    private var padding = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)

    public convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect.inset(by: padding))
    }

    public override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
