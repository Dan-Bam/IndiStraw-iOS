import UIKit
import SnapKit
import Then
import Kingfisher
import RxSwift
import RxCocoa
import RxGesture

public class ImageViewPageControl: UIView {
    private let disposeBag = DisposeBag()
    private let imageDataSources = BehaviorRelay<[String]>(value: [""])
    
    private let pagecontrolImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.backgroundColor = DesignSystemAsset.Colors.gray.color
    }
    
    private let pageControl = UIPageControl().then {
        $0.pageIndicatorTintColor = DesignSystemAsset.Colors.gray.color
        $0.currentPageIndicatorTintColor = DesignSystemAsset.Colors.mainColor.color
        $0.isUserInteractionEnabled = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addView()
        setLayout()
        setGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setGesture() {
        Observable
            .merge(
                pagecontrolImageView.rx.gesture(.swipe(direction: .left)).asObservable(),
                pagecontrolImageView.rx.gesture(.swipe(direction: .right)).asObservable()
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
                    with: owner.pagecontrolImageView,
                    duration: 0.3,
                    options: .transitionCrossDissolve,
                    animations: {
                        owner.pagecontrolImageView.kf.setImage(with: URL(
                            string: owner.imageDataSources.value[owner.pageControl.currentPage])
                        )
                    })
            }.disposed(by: disposeBag)
    }
    
    private func addView() {
        self.addSubviews(
            pagecontrolImageView, pageControl
        )
    }
    
    private func setLayout() {
        pagecontrolImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(140)
        }
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(pagecontrolImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

public extension ImageViewPageControl {
    func configure(imageList: [String]) {
        imageDataSources.accept(imageList)
        pagecontrolImageView.kf.setImage(with: URL(string: imageList[0]))
        pageControl.numberOfPages = imageList.count
    }
}
