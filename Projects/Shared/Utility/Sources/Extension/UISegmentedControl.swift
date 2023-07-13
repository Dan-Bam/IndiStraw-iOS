import UIKit

public extension UISegmentedControl {
    func removeBackgroundAndDidiver() {
        let image = UIImage()
        self.setBackgroundImage(image, for: .normal, barMetrics: .default)
        self.setBackgroundImage(image, for: .selected, barMetrics: .default)
        self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        
        self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    
    func addSegmentedControlUnderLinde() -> CGRect {
        let width = (self.bounds.size.width / CGFloat(self.numberOfSegments)) - 18
        let height: CGFloat = 2.0
        let xPosition = CGFloat(self.selectedSegmentIndex) * width
        let yPosition = self.bounds.size.height + 23 - height
        let frame = CGRect(x: xPosition + 9, y: yPosition, width: width, height: height)
        
        return frame
    }
}
