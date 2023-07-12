import UIKit
import BaseFeature
import DesignSystem
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxGesture

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
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    private let disposeBag = DisposeBag()
    
    private let profileButton = UIBarButtonItem().then {
        $0.image = DesignSystemAsset.Images.profileIcon.image
        $0.tintColor = .white
    }
    
    private let bannerImageView = ImageViewPageControlComponent().then {
        $0.backgroundColor = DesignSystemAsset.Colors.gray.color
        $0.layer.cornerRadius = 10
    }
    
    private let underlineView = UIView().then {
        $0.backgroundColor = DesignSystemAsset.Colors.mainColor.color
        $0.layer.cornerRadius = 1
    }
    
    private let segmentedControl = UISegmentedControl(items: ["최근", "추천", "인기"]).then {
        $0.selectedSegmentIndex = 0
        $0.setTitleTextAttributes([
            .foregroundColor: DesignSystemAsset.Colors.darkGray.color,
            .font: DesignSystemFontFamily.Suit.semiBold.font(size: 16)
        ], for: .normal)
        $0.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
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
    
    private let moviesViewAllButton = UIButton().then {
        $0.setTitle("전체 보기 >", for: .normal)
        $0.setTitleColor(DesignSystemAsset.Colors.gray.color, for: .normal)
        $0.titleLabel?.font = DesignSystemFontFamily.Suit.regular.font(size: 12)
        $0.backgroundColor = .black
    }
    
    private let crowdFundingTitleLabel = UILabel().then {
        $0.text = "크라우드 펀딩"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.semiBold.font(size: 16)
    }
    
    private let crowdFundingTableView = UITableView().then {
        $0.rowHeight = 154
        $0.backgroundColor = .black
        $0.register(CrowdFundingCell.self, forCellReuseIdentifier: CrowdFundingCell.identifier)
    }
    
    private let crowdFundingViewAllButton = UIButton().then {
        $0.setTitle("전체 보기 >", for: .normal)
        $0.setTitleColor(DesignSystemAsset.Colors.gray.color, for: .normal)
        $0.titleLabel?.font = DesignSystemFontFamily.Suit.regular.font(size: 12)
        $0.backgroundColor = .black
    }
    
    override func configureVC() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = profileButton
        bindUI()
        moviesCollectionView.delegate = self
        segmentedControl.removeBackgroundAndDidiver()
        
        underlineView.frame = segmentedControl.addSegmentedControlUnderLinde()
        segmentedControl.addSubview(underlineView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.crowdFundingTableView.addObserver(self, forKeyPath: ContentSizeKey.key, options: .new, context: nil)
        viewModel.requestPopularMoviesList()
        viewModel.requestCrowdFundingList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.crowdFundingTableView.removeObserver(self, forKeyPath: ContentSizeKey.key)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == ContentSizeKey.key {
            if object is UITableView {
                if let newValue = change?[.newKey] as? CGSize {
                    print(newValue)
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
            bannerImageView, segmentedControl,
            moviesCollectionView, moviesViewAllButton,
            crowdFundingTitleLabel, crowdFundingTableView,
            crowdFundingViewAllButton
        )
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
        
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(bannerImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(15)
            $0.height.equalTo(23)
        }
        
        moviesCollectionView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        moviesViewAllButton.snp.makeConstraints {
            $0.top.equalTo(segmentedControl)
            $0.centerY.equalTo(segmentedControl)
            $0.trailing.equalToSuperview().inset(15)
        }
        
        crowdFundingTitleLabel.snp.makeConstraints {
            $0.top.equalTo(moviesCollectionView.snp.bottom).offset(26)
            $0.leading.equalToSuperview().inset(15)
        }
        
        crowdFundingTableView.snp.makeConstraints {
            $0.top.equalTo(crowdFundingTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        crowdFundingViewAllButton.snp.makeConstraints {
            $0.top.equalTo(crowdFundingTitleLabel)
            $0.centerY.equalTo(crowdFundingTitleLabel)
            $0.trailing.equalToSuperview().inset(15)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 109, height: collectionView.frame.height)
    }
}

extension HomeViewController {
    private func bindUI() {
        viewModel.moviesData
            .asDriver()
            .drive(moviesCollectionView.rx.items(
                cellIdentifier: MoviesCell.identifier,
                cellType: MoviesCell.self)) { (row, data, cell) in
                    cell.configure(imageUrl: data.thumbnailUrl)
                }.disposed(by: disposeBag)
        
        moviesCollectionView.rx.modelSelected(PopularMoviesModel.self)
            .bind(with: self) { owner, model in
                print("idx = \(model.movieIdx)")
                owner.viewModel.pushMovieDetailVC(idx: model.movieIdx)
            }.disposed(by: disposeBag)
        
        viewModel.fundingData
            .asDriver()
            .drive(crowdFundingTableView.rx.items(
                cellIdentifier: CrowdFundingCell.identifier,
                cellType: CrowdFundingCell.self)) { (row, data, cell) in
                    cell.configure(model: data)
                }.disposed(by: disposeBag)
        
        crowdFundingTableView.rx.modelSelected(FundingList.self)
            .bind(with: self) { owner, arg in
                owner.viewModel.pushCrowdFundingDetailVC(idx: arg.idx)
            }.disposed(by: disposeBag)
        
        segmentedControl.rx.selectedSegmentIndex.changed
            .bind(with: self) { owner, _ in
                let underlineFinalXPosition = ((self.segmentedControl.bounds.width / CGFloat(self.segmentedControl.numberOfSegments)) * CGFloat(self.segmentedControl.selectedSegmentIndex)) + 9
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
        
        crowdFundingViewAllButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.viewModel.pushCrowdFundingListVC()
            }.disposed(by: disposeBag)
    }
    
    private func removeBackgroundAndDidiver() {
        let image = UIImage()
        segmentedControl.setBackgroundImage(image, for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(image, for: .selected, barMetrics: .default)
        segmentedControl.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        
        segmentedControl.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    
    private func addSegmentedControlUnderLinde() {
        let width = (segmentedControl.bounds.size.width / CGFloat(segmentedControl.numberOfSegments)) - 18
        let height: CGFloat = 2.0
        let xPosition = CGFloat(segmentedControl.selectedSegmentIndex) * width
        let yPosition = segmentedControl.bounds.size.height + 23 - height
        let frame = CGRect(x: xPosition + 9, y: yPosition, width: width, height: height)
        underlineView.frame = frame
        segmentedControl.addSubview(underlineView)
    }
}
