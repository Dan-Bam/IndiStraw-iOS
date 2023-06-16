import UIKit
import BaseFeature
import SnapKit
import Then
import DesignSystem

var imageData: [String] = []

class HomeViewController: BaseVC<HomeViewModel> {
    private let pageControl = UIPageControl().then {
        $0.setCurrentPageIndicatorImage(DesignSystemAsset.Images.pageControlIndicator.image, forPage: 2)
        $0.currentPage = 0
        $0.numberOfPages = imageData.count
    }
}
