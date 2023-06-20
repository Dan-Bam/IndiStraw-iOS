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
    var moviesData = BehaviorRelay<[MovieesModel]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    private let profileButton = UIBarButtonItem().then {
        $0.image = DesignSystemAsset.Images.profileIcon.image
        $0.tintColor = .white
    }
    
    lazy var moviesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 9
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.register(MoviesCell.self, forCellWithReuseIdentifier: MoviesCell.identifier)

        return view
    }()
    
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
        $0.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: DesignSystemAsset.Colors.darkGray.color,
            NSAttributedString.Key.font: DesignSystemFontFamily.Suit.semiBold.font(size: 16)
        ], for: .normal)
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
                bannerImageView.rx.gesture(.swipe(direction: .left)).asObservable(),
                bannerImageView.rx.gesture(.swipe(direction: .right)).asObservable()
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
    
    func bindUI() {
        moviesData
            .asDriver()
            .drive(moviesCollectionView.rx.items(cellIdentifier: MoviesCell.identifier,
                                                 cellType: MoviesCell.self)) { (row, data, cell) in
                cell.prepare(model: data)
            }.disposed(by: disposeBag)
        
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
        
        profileButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.viewModel.pushProfileVC()
            }.disposed(by: disposeBag)
    }
    
    override func viewWillLayoutSubviews() {
        removeBackgroundAndDidiver()
    }
    
    override func configureVC() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "hihi"
        navigationItem.rightBarButtonItem = profileButton
        setGesture()
        bindUI()
        
        let width = segCon.bounds.size.width / CGFloat(segCon.numberOfSegments)
        let height: CGFloat = 2.0
        let xPosition = CGFloat(segCon.selectedSegmentIndex) * width
        let yPosition = segCon.bounds.size.height - height
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        underlineView.frame = frame
        segCon.addSubview(underlineView)
    }
    
    override func addView() {
        view.addSubviews(bannerImageView, pageControl, segCon, moviesCollectionView)
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
        
        moviesCollectionView.snp.makeConstraints {
            $0.top.equalTo(segCon.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(moviesCollectionView.frame.height)
        }
    }
}
