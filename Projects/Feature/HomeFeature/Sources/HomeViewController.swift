import UIKit
import BaseFeature
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxGesture
import DesignSystem

enum ContentSizeKey {
    static let key = "contentSize"
}

var bannerImageSources = [
    DesignSystemAsset.Images.testImage.image,
    DesignSystemAsset.Images.testImage.image,
    DesignSystemAsset.Images.testImage.image,
    DesignSystemAsset.Images.testImage.image
]

class HomeViewController: BaseVC<HomeViewModel> {
    var moviesData = BehaviorRelay<[MoviesModel]>(value: [])
    var fundingData = BehaviorRelay<[FundingList]>(value: [])
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    private let disposeBag = DisposeBag()
    
    private let profileButton = UIBarButtonItem().then {
        $0.image = DesignSystemAsset.Images.profileIcon.image
        $0.tintColor = .white
    }
    
    private let bannerImageView = UIImageView().then {
        $0.backgroundColor = DesignSystemAsset.Colors.gray.color
        $0.layer.cornerRadius = 10
        $0.image = bannerImageSources[0]
    }
    
    private let pageControl = UIPageControl().then {
        $0.isUserInteractionEnabled = false
        $0.currentPage = 0
        $0.numberOfPages = bannerImageSources.count
        $0.setCurrentPageIndicatorImage(
            DesignSystemAsset.Images.pagecontrol.image,
            forPage: $0.currentPage
        )
    }
    
    private let underlineView = UIView().then {
        $0.backgroundColor = DesignSystemAsset.Colors.mainColor.color
        $0.layer.cornerRadius = 10
    }

    private let segmentedControl = UISegmentedControl(items: ["최근", "추천", "인기"]).then {
        $0.selectedSegmentIndex = 0
//        $0.setTitleTextAttributes([
//            NSAttributedString.Key.foregroundColor: DesignSystemAsset.Colors.darkGray.color,
//            NSAttributedString.Key.font: DesignSystemFontFamily.Suit.semiBold.font(size: 16)
//        ], for: .normal)
//        $0.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    lazy var moviesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 12
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .black
        view.register(MoviesCell.self, forCellWithReuseIdentifier: MoviesCell.identifier)
        return view
    }()
    
    private let crowdFundingTitleLabel = UILabel().then {
        $0.text = "크라우드 펀딩"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.semiBold.font(size: 16)
    }
    
    private let crowdFundingTableView = UITableView().then {
        $0.rowHeight = 150
        $0.backgroundColor = .black
        $0.register(CrowdFundingCell.self, forCellReuseIdentifier: CrowdFundingCell.identifier)
    }
    
    private func removeBackgroundAndDidiver() {
        let image = UIImage()
        segmentedControl.setBackgroundImage(image, for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(image, for: .selected, barMetrics: .default)
        segmentedControl.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        
        segmentedControl.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
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
            .drive(moviesCollectionView.rx.items(
                cellIdentifier: MoviesCell.identifier,
                cellType: MoviesCell.self)) { (row, data, cell) in
                cell.configure(model: data)
            }.disposed(by: disposeBag)
        
        fundingData
            .asDriver()
            .drive(crowdFundingTableView.rx.items(
                cellIdentifier: CrowdFundingCell.identifier,
                cellType: CrowdFundingCell.self)) { (row, data, cell) in
                    cell.configure(model: data)
                }.disposed(by: disposeBag)
        
        crowdFundingTableView.rx.modelSelected(FundingList.self)
            .bind(with: self) { owner, arg in
                owner.viewModel.pushCrowdFundingVC(idx: arg.idx)
            }.disposed(by: disposeBag)
        
        segmentedControl.rx.selectedSegmentIndex.changed
            .bind(with: self) { owner, _ in
                let underlineFinalXPosition = (self.segmentedControl.bounds.width / CGFloat(self.segmentedControl.numberOfSegments)) * CGFloat(self.segmentedControl.selectedSegmentIndex)
                UIView.animate(
                    withDuration: 0.1,
                    animations: {
                        self.underlineView.frame.origin.x = underlineFinalXPosition
                    }
                )
                switch owner.segmentedControl.selectedSegmentIndex {

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
        navigationItem.rightBarButtonItem = profileButton
        setGesture()
        bindUI()
        moviesCollectionView.delegate = self
        
        let width = segmentedControl.bounds.size.width / CGFloat(segmentedControl.numberOfSegments)
        let height: CGFloat = 2.0
        let xPosition = CGFloat(segmentedControl.selectedSegmentIndex) * width
        let yPosition = segmentedControl.bounds.size.height - height - 9
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        underlineView.frame = frame
        segmentedControl.addSubview(underlineView)
        
        moviesData.accept([MoviesModel(imageUrl: "https://www.kukinews.com/data/kuk/image/2022/05/18/kuk202205180005.680x.0.jpg"), MoviesModel(imageUrl: "https://www.kukinews.com/data/kuk/image/2022/05/18/kuk202205180005.680x.0.jpg"), MoviesModel(imageUrl: "https://www.kukinews.com/data/kuk/image/2022/05/18/kuk202205180005.680x.0.jpg"), MoviesModel(imageUrl: "https://www.kukinews.com/data/kuk/image/2022/05/18/kuk202205180005.680x.0.jpg"), MoviesModel(imageUrl: "https://www.kukinews.com/data/kuk/image/2022/05/18/kuk202205180005.680x.0.jpg")])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.crowdFundingTableView.addObserver(self, forKeyPath: ContentSizeKey.key, options: .new, context: nil)
        
        viewModel.requestCrowdFundingList { [weak self] result in
            switch result {
            case .success(let dataArray):
                self?.fundingData.accept(dataArray)
            case .failure:
                return
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.crowdFundingTableView.removeObserver(self, forKeyPath: ContentSizeKey.key)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == ContentSizeKey.key {
            if object is UITableView {
                if let newValue = change?[.newKey] as? CGSize {
                    crowdFundingTableView.snp.updateConstraints {
                        $0.height.equalTo(newValue.height + 50)
                    }
                }
            }
        }
    }
    
    override func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubviews(
            segmentedControl, pageControl,
            bannerImageView, moviesCollectionView,
            crowdFundingTitleLabel, crowdFundingTableView
        )
        
        segmentedControl.center = view.center
    }
    
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints {
            $0.centerX.width.top.bottom.equalToSuperview()
        }
        
        bannerImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(170)
        }

        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bannerImageView.snp.bottom).offset(16)
        }
 
//        segmentedControl.snp.makeConstraints {
//            $0.top.equalTo(pageControl.snp.bottom).offset(20)
//            $0.leading.equalToSuperview().inset(15)
//            $0.height.equalTo(23)
//        }

        moviesCollectionView.snp.makeConstraints {
            $0.top.equalTo(pageControl.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }

        crowdFundingTitleLabel.snp.makeConstraints {
            $0.top.equalTo(moviesCollectionView.snp.bottom).offset(26)
            $0.leading.equalToSuperview().inset(15)
        }

        crowdFundingTableView.snp.makeConstraints {
            $0.top.equalTo(crowdFundingTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 109, height: collectionView.frame.height)
    }
}
