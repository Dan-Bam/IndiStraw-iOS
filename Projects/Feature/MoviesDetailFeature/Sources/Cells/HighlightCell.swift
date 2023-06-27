import UIKit

class HighlightCell: UICollectionViewCell {
    static let identifier = "HighlightCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
