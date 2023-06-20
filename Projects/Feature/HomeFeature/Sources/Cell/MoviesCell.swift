import UIKit
import Then
import SnapKit
import Kingfisher

class MoviesCell: UICollectionViewCell {
    static let identifier = "MoviesCell"
    
    private let moviesImageView = UIImageView().then {
        $0.layer.cornerRadius = 10
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(moviesImageView)
        moviesImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(model: MovieesModel) {
        print("model.imageUrl = \(model.imageUrl)")
        moviesImageView.kf.setImage(with: URL(string: model.imageUrl))
    }
}
