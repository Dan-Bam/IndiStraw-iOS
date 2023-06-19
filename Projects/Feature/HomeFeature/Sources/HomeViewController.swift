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
    DesignSystemAsset.Images.testImage.image,
    DesignSystemAsset.Images.testImage.image,
    DesignSystemAsset.Images.testImage.image
    
]

var segConArray = ["최근", "추천", "인기"]

class HomeViewController: BaseVC<HomeViewModel> {
    private let disposeBag = DisposeBag()
    
    private let bannerImageView = UIImageView().then {
        $0.layer.cornerRadius = 10
        $0.image = bannerImageSources[0]
    }
    
    private let pageControl = UIPageControl().then {
        $0.isUserInteractionEnabled = false
        $0.currentPage = 0
        $0.numberOfPages = bannerImageSources.count
        $0.setCurrentPageIndicatorImage(
            DesignSystemAsset.Images.pageControlIndicator.image,
            forPage: $0.currentPage
        )
    }
    
    private let underlineView = UIView().then {
        $0.backgroundColor = DesignSystemAsset.Colors.mainColor.color
        $0.layer.cornerRadius = 10
    }
    
    private let segCon = UISegmentedControl(items: segConArray).then {
        $0.clipsToBounds = false
        $0.selectedSegmentIndex = 0
        $0.setTitleTextAttributes([.foregroundColor: DesignSystemAsset.Colors.darkGray.color,
                                   .font: DesignSystemFontFamily.Suit.semiBold.font(size: 14)],
                                  for: .normal)
        $0.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    private func removeBackgroundAndDidiver() {
        let image = UIImage()
        segCon.setBackgroundImage(image, for: .normal, barMetrics: .default)
        segCon.setBackgroundImage(image, for: .selected, barMetrics: .default)
        segCon.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        
        segCon.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
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
    
    override func viewWillLayoutSubviews() {
        removeBackgroundAndDidiver()
    }
    
    override func configureVC() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "hihi"
        setGesture()
        
        let width = segCon.bounds.size.width / CGFloat(segCon.numberOfSegments)
        let height: CGFloat = 2.0
        let xPosition = CGFloat(segCon.selectedSegmentIndex) * width
        let yPosition = segCon.bounds.size.height - height
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        underlineView.frame = frame
        segCon.addSubview(underlineView)
        
        segCon.rx.selectedSegmentIndex.changed
            .bind(with: self) { owner, _ in
                let underlineFinalXPosition = (self.segCon.bounds.width / CGFloat(self.segCon.numberOfSegments)) * CGFloat(self.segCon.selectedSegmentIndex)
                UIView.animate(
                    withDuration: 0.1,
                    animations: {
                        self.underlineView.frame.origin.x = underlineFinalXPosition
                    }
                )
                switch owner.segCon.selectedSegmentIndex {

                default:
                    return
                }
            }.disposed(by: disposeBag)
    }
    
    override func addView() {
        view.addSubviews(bannerImageView, pageControl, segCon)
        segCon.addSubview(underlineView)
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
        
        segCon.snp.makeConstraints {
            $0.top.equalTo(pageControl.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(15)
            $0.height.equalTo(23)
        }
    }
}
