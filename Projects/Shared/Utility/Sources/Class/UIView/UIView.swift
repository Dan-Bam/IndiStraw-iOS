import UIKit

extension UIView {
    public func addSubviews(_ subView: UIView...) {
        subView.forEach(addSubview(_:))
    }
}
