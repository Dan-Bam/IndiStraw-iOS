import UIKit

extension UITextView {
    func setPlaceholderPadding(padding: Int) {
        self.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
}
