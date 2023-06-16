import UIKit
import BaseFeature
import SnapKit
import Then

var imageData: [String] = []

class HomeViewController: BaseVC<HomeViewModel> {
    
    private let pageControl = UIPageControl().then {
        $0.setCurrentPageIndicatorImage(, forPage: <#T##Int#>)
        $0.currentPage = 0
        $0.numberOfPages = imageData.count
    }
}
