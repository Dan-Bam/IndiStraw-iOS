import UIKit
import BaseFeature
import DesignSystem
import SnapKit
import Then
import AVKit

class MoviesDetailViewController: BaseVC<MoviesDetailViewModel> {
    private let thumbnailImageView = UIImageView().then {
        $0.image = DesignSystemAsset.Images.testImage.image
    }
    
    private let playImageIconView = UIImageView().then {
        $0.image = DesignSystemAsset.Images.playIcon.image
        $0.tintColor = .white
    }
    
    private let movieTitleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.semiBold.font(size: 18)
    }
    
    private let movieDescriptionLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = DesignSystemAsset.Colors.gray.color
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 12)
    }
    
    override func addView() {
        view.addSubviews(
            thumbnailImageView, movieTitleLabel,
            movieDescriptionLabel
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
    }
}
