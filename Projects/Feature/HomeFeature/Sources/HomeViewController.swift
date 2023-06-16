import UIKit
import BaseFeature
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxGesture
import DesignSystem

var imageData: [String] = []

class HomeViewController: BaseVC<HomeViewModel> {
    private let disposeBag = DisposeBag()
    
    private let pageControl = UIPageControl().then {
        $0.setCurrentPageIndicatorImage(DesignSystemAsset.Images.pageControlIndicator.image, forPage: 2)
        $0.currentPage = 0
        $0.numberOfPages = imageData.count
    }
    
    override func configureVC() {
        Observable
            .merge(
                view.rx.gesture(.swipe(direction: .left)).asObservable(),
                view.rx.gesture(.swipe(direction: .right)).asObservable()
            )
            .bind(with: self) { owner, gesture in
                guard let gesture = gesture as? UISwipeGestureRecognizer else { return }
                
                switch gesture.direction {
                case .left:
                    owner.pageControl.currentPage += 1
                case .right:
                    owner.pageControl.currentPage -= 1
                default:
                    break
                }
            }.disposed(by: disposeBag)
    }
    
    override func addView() {
        
    }
    
    override func setLayout() {
        
    }
}
