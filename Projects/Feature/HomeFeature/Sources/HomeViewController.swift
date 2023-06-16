import UIKit
import BaseFeature
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxGesture
import DesignSystem

var bannerImageSources = [
    DesignSystemAsset.Images.testImage.image,
    DesignSystemAsset.Images.inputPhoto.image,
    UIImage(systemName: "check"),
    UIImage(systemName: "check")

]

class HomeViewController: BaseVC<HomeViewModel> {
    private let disposeBag = DisposeBag()
    
    private let bannerImageView = UIImageView().then {
        $0.image = bannerImageSources[0]
    }
    
    private let pageControl = UIPageControl().then {
        $0.currentPage = 0
        $0.numberOfPages = bannerImageSources.count
        $0.setCurrentPageIndicatorImage(DesignSystemAsset.Images.pageControlIndicator.image, forPage: 0)
    }
    
    private func setGesture() {
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
                
                UIView.transition(
                    with: owner.bannerImageView,
                    duration: 0.3,
                    options: .transitionCrossDissolve,
                    animations: {
                        owner.bannerImageView.image = bannerImageSources[owner.pageControl.currentPage]
                    })
            }.disposed(by: disposeBag)
    }
    
    override func configureVC() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "hihi"
        setGesture()
    }
    
    override func addView() {
        view.addSubviews(bannerImageView, pageControl)
    }
    
    override func setLayout() {
        bannerImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(21)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(170)
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bannerImageView.snp.bottom).offset(16)
        }
    }
}
