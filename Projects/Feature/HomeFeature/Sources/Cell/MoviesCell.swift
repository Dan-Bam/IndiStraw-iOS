import UIKit
import Then
import SnapKit
import Kingfisher

class MoviesCell: UICollectionViewCell {
    static let identifier = "MoviesCell"
    
    private let moviesImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10
        
        self.addSubview(moviesImageView)
        
        moviesImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(109)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: PopularMoviesModel) {
        moviesImageView.kf.setImage(with: URL(string: model.thumbnailUrl))
    }
}
