import UIKit
import BaseFeature
import SnapKit
import Then
import DesignSystem
import Utility

class CreateMoviesViewController: BaseVC<CreateMoviesViewModel> {
    private let thumbnailTitleLabel = UILabel().then {
        $0.text = "썸네일"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 16)
    }
    
    private let thumbnailWrapperView = UIView().then {
        $0.backgroundColor = DesignSystemAsset.Colors.darkgray3.color
        $0.layer.cornerRadius = 20
    }
    
    private let thumbnailDescriptionLabel = UILabel().then {
        $0.text = "썸네일을 등록해 주세요."
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.semiBold.font(size: 16)
    }
    
    private let thumbnailImageUploadButton = BasePaddingButton(padding: UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)).then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.backgroundColor = DesignSystemAsset.Colors.mainColor.color
        $0.setTitle("+ 이미지 업로드", for: .normal)
    }
    
    private let movieTitleLabel = UILabel().then {
        $0.text = "영화"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 16)
    }
    
    private let movieRegisterButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = DesignSystemAsset.Colors.darkgray3.color
    }
    
    private let subjectTitleLabel = UILabel().then {
        $0.text = "제목"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 16)
    }
    
    private let subjectTextField = TextFieldBoxComponent().then {
        $0.setPlaceholer(text: "제목을 입력해 주세요.")
    }
    
    private let descriptionTitleLabel = UILabel().then {
        $0.text = "소개"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 16)
    }
    
    private let descriptionTextField = TextFieldBoxComponent().then {
        $0.setPlaceholer(text: "소개글을 입력해 주세요.")
    }
    
    override func configureVC() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func addView() {
        view.addSubviews(
            thumbnailTitleLabel, thumbnailWrapperView,
            movieTitleLabel, movieRegisterButton,
            subjectTitleLabel, subjectTextField,
            descriptionTitleLabel, descriptionTextField
        )
        
        thumbnailWrapperView.addSubviews(
            thumbnailDescriptionLabel, thumbnailImageUploadButton
        )
    }
    
    override func setLayout() {
        thumbnailTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(29)
            $0.leading.equalToSuperview().inset(15)
        }
        
        thumbnailWrapperView.snp.makeConstraints {
            $0.top.equalTo(thumbnailTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        
        thumbnailDescriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(36)
            $0.centerX.equalToSuperview()
        }
        
        thumbnailImageUploadButton.snp.makeConstraints {
            $0.top.equalTo(thumbnailDescriptionLabel.snp.bottom).offset(26)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(29)
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailWrapperView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(15)
        }
        
        movieRegisterButton.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(54)
        }
        
        subjectTitleLabel.snp.makeConstraints {
            $0.top.equalTo(movieRegisterButton.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(15)
        }
        
        subjectTextField.snp.makeConstraints {
            $0.top.equalTo(subjectTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(54)
        }
        
        
    }
}
