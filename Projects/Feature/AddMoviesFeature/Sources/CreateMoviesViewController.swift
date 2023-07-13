import UIKit
import BaseFeature
import SnapKit
import Then
import DesignSystem
import Utility

class CreateMoviesViewController: BaseVC<CreateMoviesViewModel> {
    private let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
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
    
    private let thumbnailImageUploadButton = BasePaddingButton(padding: UIEdgeInsets(top: 3, left: 12, bottom: 3, right: 12)).then {
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
    
    private let descriptionTextView = UITextView().then {
        $0.textContainerInset = UIEdgeInsets(top: 17, left: 13, bottom: 0, right: 0)
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 14)
        $0.textColor = DesignSystemAsset.Colors.gray.color
        $0.layer.cornerRadius = 10
        $0.backgroundColor = DesignSystemAsset.Colors.darkgray3.color
        $0.text = "소개글을 입력해 주세요."
    }
    
    private let fundingTitleLabel = UILabel().then {
        $0.text = "펀딩 여부"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 14)
    }
    
    private let fundingTextLabel = TextFieldBoxComponent().then {
        $0.text = "크라우드 펀딩을 사용하셨나요?"
        $0.textColor = .white
    }
    
    
    
    private let continueButton = ButtonComponent().then {
        $0.setTitle("계속하기", for: .normal)
    }
    
    override func configureVC() {
        navigationController?.navigationBar.prefersLargeTitles = false
        
        descriptionTextView.delegate = self
    }
    
    override func addView() {
        view.addSubview(
            scrollView
        )
        
        scrollView.addSubview(contentView)
        contentView.addSubviews(
            thumbnailTitleLabel, thumbnailWrapperView,
            movieTitleLabel, movieRegisterButton,
            subjectTitleLabel, subjectTextField,
            descriptionTitleLabel, descriptionTextView, fundingTitleLabel, fundingTextLabel,
            continueButton
        )
        
        thumbnailWrapperView.addSubviews(
            thumbnailDescriptionLabel, thumbnailImageUploadButton
        )
    }
    
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.bottom.width.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        thumbnailTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(29)
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
        
        descriptionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(subjectTextField.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(15)
        }
        
        descriptionTextView.snp.makeConstraints {
            $0.top.equalTo(descriptionTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(80)
        }
        
        fundingTitleLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionTextView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(15)
        }
        
        fundingTextLabel.snp.makeConstraints {
            $0.top.equalTo(fundingTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(54)
        }
        
        continueButton.snp.makeConstraints {
            $0.top.equalTo(fundingTextLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(79)
            $0.height.equalTo(54)
        }
    }
}

extension CreateMoviesViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "크라우드 펀딩을 사용하셨나요?" {
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "크라우드 펀딩을 사용하셨나요?"
            textView.textColor = .lightGray
//            updateCountLabel(characterCount: 0)
        }
    }
}
