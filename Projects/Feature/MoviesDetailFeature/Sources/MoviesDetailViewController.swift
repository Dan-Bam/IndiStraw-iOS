import UIKit
import BaseFeature
import DesignSystem
import SnapKit
import Then
import RxSwift
import RxCocoa

class MoviesDetailViewController: BaseVC<MoviesDetailViewModel> {
    //    var highlightData: BehaviorRelay<>
    
    private let thumbnailImageView = UIImageView().then {
        $0.image = DesignSystemAsset.Images.testImage.image
    }
    
    private let playImageIconView = UIImageView().then {
        $0.image = DesignSystemAsset.Images.playIcon.image
        $0.tintColor = .white
    }
    
    private let movieTitleLabel = UILabel().then {
        $0.text = "스파이더맨"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.semiBold.font(size: 18)
    }
    
    private let movieDescriptionLabel = UILabel().then {
        $0.text = """
        스파이더맨은 스티브 딧코가 창작한 마블 코믹스의 슈퍼 히어로이
        다. 그는 1962년 8월의 어메이징 판타지15호에 처음 등장했다.그
        는 마블 코믹스에서 출판한 만화책뿐만 아니라 마블 유니버스를 배
        경으로 한 여러영화, tv프로이다.
        """
        $0.numberOfLines = 0
        $0.textColor = DesignSystemAsset.Colors.gray.color
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 12)
    }
    
    private let highlightTitleLabel = UILabel().then {
        $0.text = "하이라이트"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 16)
    }
    
    private let highlightCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(HighlightCell.self, forCellWithReuseIdentifier: HighlightCell.identifier)
    }
    
    private let castLabel = UILabel().then {
        $0.text = "출연진"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 18)
    }
    
    func bindUI() {
        
    }
        
    override func configureVC() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func addView() {
        view.addSubviews(
            thumbnailImageView, movieTitleLabel,
            movieDescriptionLabel, highlightTitleLabel,
            highlightCollectionView, castLabel
        )
        
        thumbnailImageView.addSubview(playImageIconView)
    }
    
    override func setLayout() {
        thumbnailImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(21)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(222)
        }
        
        playImageIconView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(60)
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(25)
        }
        
        movieDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        
        highlightTitleLabel.snp.makeConstraints {
            $0.top.equalTo(movieDescriptionLabel.snp.bottom).offset(44)
            $0.leading.equalToSuperview().inset(25)
        }
        
        highlightCollectionView.snp.makeConstraints {
            $0.top.equalTo(highlightTitleLabel.snp.bottom).offset(14)
            $0.leading.equalTo(highlightTitleLabel)
        }
        
        castLabel.snp.makeConstraints {
            $0.top.equalTo(highlightCollectionView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(25)
        }
    }
}
