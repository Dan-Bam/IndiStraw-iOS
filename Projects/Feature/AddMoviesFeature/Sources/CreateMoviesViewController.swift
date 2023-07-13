import UIKit
import BaseFeature
import SnapKit
import Then
import DesignSystem

class CreateMoviesViewController: BaseVC<CreateMoviesViewModel> {
    private let thumbnailTitleLabel = UILabel().then {
        $0.text = "썸네일"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 16)
    }
    
    private let movieTitleLabel = UILabel().then {
        $0.text = "영화"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 16)
    }
    
    private let subjectTitleLabel = UILabel().then {
        $0.text = "제목"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 16)
    }
    
    private let descriptionTitleLabel = UILabel().then {
        $0.text = "소개"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 16)
    }
}
