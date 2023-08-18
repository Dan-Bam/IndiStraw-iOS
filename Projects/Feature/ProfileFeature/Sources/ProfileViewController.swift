import UIKit
import BaseFeature
import DesignSystem
import SnapKit
import Then
import RxSwift
import RxCocoa

enum ContentSizeKey {
    static let key = "contentSize"
}

public class ProfileViewController: BaseVC<ProfileViewModel> {
    private let disposeBag = DisposeBag()
    
    private let settingButton = UIBarButtonItem().then {
        $0.tintColor = .white
        $0.image = UIImage(systemName: "gearshape")
    }
    
    private let profileImageButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).then {
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = false
        $0.isEnabled = true
        $0.backgroundColor = DesignSystemAsset.Colors.gray.color
        $0.setImage(
            DesignSystemAsset.Images.profileIcon.image
                .withConfiguration(UIImage.SymbolConfiguration(
                    pointSize: 30,
                    weight: .light
                )), for: .normal)
        $0.tintColor = .white
        $0.layer.cornerRadius = 40
    }
    
    private let userNameLabel = UILabel().then {
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.bold.font(size: 20)
    }
    
    private let movieSegmentedControl = UISegmentedControl(items: ["최근시청", "출연작품"]).then {
        $0.selectedSegmentIndex = 0
        $0.setTitleTextAttributes([
            .foregroundColor: DesignSystemAsset.Colors.darkGray.color,
            .font: DesignSystemFontFamily.Suit.semiBold.font(size: 16)
        ], for: .normal)
        $0.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    private let movieSegUnderlineView = UIView().then {
        $0.backgroundColor = DesignSystemAsset.Colors.mainColor.color
        $0.layer.cornerRadius = 1
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
    
    private let fundingSegmentedControl = UISegmentedControl(items: ["크라우드 펀딩", "마이 펀딩"]).then {
        $0.selectedSegmentIndex = 0
        $0.setTitleTextAttributes([
            .foregroundColor: DesignSystemAsset.Colors.darkGray.color,
            .font: DesignSystemFontFamily.Suit.semiBold.font(size: 16)
        ], for: .normal)
        $0.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    private let fundingSegUnderlineView = UIView().then {
        $0.backgroundColor = DesignSystemAsset.Colors.mainColor.color
        $0.layer.cornerRadius = 1
    }
    
    private let fundingTableView = UITableView().then {
        $0.rowHeight = 154
        $0.backgroundColor = .black
        $0.register(FundingCell.self, forCellReuseIdentifier: FundingCell.identifier)
    }
    
    public override func configureVC() {
        navigationItem.rightBarButtonItem = settingButton
        movieSegmentedControl.removeBackgroundAndDidiver()
        fundingSegmentedControl.removeBackgroundAndDidiver()
        
        movieSegUnderlineView.frame = movieSegmentedControl.addSegmentedControlUnderLinde()
        movieSegmentedControl.addSubview(movieSegUnderlineView)
        
        fundingSegUnderlineView.frame = fundingSegmentedControl.addSegmentedControlUnderLinde()
        fundingSegmentedControl.addSubview(fundingSegUnderlineView)
        
        settingButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.viewModel.pushSettingVC()
            }.disposed(by: disposeBag)
        
        viewModel.requestProfileName()
            .observe(on: MainScheduler.instance)
            .bind(with: self) { owner, name in
                owner.userNameLabel.text = name + "님"
            }.disposed(by: disposeBag)

        viewModel.reqeustMyFunding()
            .observe(on: MainScheduler.instance)
            .bind(to: fundingTableView.rx.items(
                cellIdentifier: FundingCell.identifier,
                cellType: FundingCell.self)) { (_, data, cell) in
                    cell.configure(model: data)
            }.disposed(by: disposeBag)
        
        movieSegmentedControl.rx.selectedSegmentIndex.changed
            .bind(with: self) { owner, _ in
                let underlineFinalXPosition = ((self.movieSegmentedControl.bounds.width / CGFloat(self.movieSegmentedControl.numberOfSegments)) * CGFloat(self.movieSegmentedControl.selectedSegmentIndex)) + 9
                UIView.animate(
                    withDuration: 0.1,
                    animations: {
                        self.movieSegUnderlineView.frame.origin.x = underlineFinalXPosition
                    }
                )
                switch owner.movieSegmentedControl.selectedSegmentIndex {

                default:
                    return
                }
            }.disposed(by: disposeBag)
        
        fundingSegmentedControl.rx.selectedSegmentIndex.changed
            .bind(with: self) { owner, _ in
                let underlineFinalXPosition = ((self.fundingSegmentedControl.bounds.width / CGFloat(self.fundingSegmentedControl.numberOfSegments)) * CGFloat(self.fundingSegmentedControl.selectedSegmentIndex)) + 9
                UIView.animate(
                    withDuration: 0.1,
                    animations: {
                        self.fundingSegUnderlineView.frame.origin.x = underlineFinalXPosition
                    }
                )
                switch owner.fundingSegmentedControl.selectedSegmentIndex {

                default:
                    return
                }
            }.disposed(by: disposeBag)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fundingTableView.addObserver(self, forKeyPath: ContentSizeKey.key, options: .new, context: nil)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        self.fundingTableView.removeObserver(self, forKeyPath: ContentSizeKey.key)
    }

    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == ContentSizeKey.key {
            if object is UITableView {
                if let newValue = change?[.newKey] as? CGSize {
                    print(newValue)
                    fundingTableView.snp.updateConstraints {
                        $0.height.equalTo(newValue.height + 50)
                    }
                }
            }
        }
    }
    
    public override func addView() {
        view.addSubviews(
            profileImageButton, userNameLabel,
            movieSegmentedControl, moviesCollectionView,
            fundingSegmentedControl, fundingTableView
        )
    }
    
    public override func setLayout() {
        profileImageButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(17)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(80)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageButton.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
        }
        
        movieSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(15)
            $0.height.equalTo(23)
        }
        
        moviesCollectionView.snp.makeConstraints {
            $0.top.equalTo(movieSegmentedControl.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        fundingSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(moviesCollectionView.snp.bottom).offset(44)
            $0.leading.equalToSuperview().inset(15)
            $0.height.equalTo(23)
        }
        
        fundingTableView.snp.makeConstraints {
            $0.top.equalTo(fundingSegmentedControl.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
