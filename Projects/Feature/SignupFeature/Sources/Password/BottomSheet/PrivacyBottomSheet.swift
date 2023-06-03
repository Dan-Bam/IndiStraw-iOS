import UIKit
import SnapKit
import Then
import DesignSystem
import Utility

class PrivacyBottomSheet: UIViewController {
    private let allAgreeWrapperButton = UIButton()
    
    private let allAgreeChildButton = UIButton().then {
        $0.layer.borderColor = DesignSystemAsset.Colors.exampleText.color.cgColor
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 5
    }
    
    private let allAgreeChildLabel = UILabel().then {
        $0.text = "전체동의"
        $0.textColor = .white
    }
    
    private let separatorLine = UIView().then {
        $0.backgroundColor = DesignSystemAsset.Colors.line.color
    }
    
    private let termsOfUseChildImageView = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark")?.withTintColor(DesignSystemAsset.Colors.exampleText.color)
    }
    
    private let termsOfUseWrapperButton = UIButton()
    
    private let termsOfUseChileLabel = UILabel().then {
        $0.text = "[필수] 이용약관 동의"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 16)
    }
    
    private let termsOfUseSeeMoreButton = UIButton().then {
        $0.setTitle("자세히보기", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = DesignSystemFontFamily.Suit.medium.font(size: 12)
        $0.setUnderline()
    }
    
    private let personalInformationWrapperButton = UIButton()
    
    private let personalInformationChildImageView = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark")?.withTintColor(DesignSystemAsset.Colors.exampleText.color)
    }
    
    private let personalInformationChildLabel = UILabel().then {
        $0.text = "[필수] 개인정보 수집 및 이용 동의"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 16)
    }
    
    private let personalInformationSeeMoreButton = UIButton().then {
        $0.setTitle("자세히보기", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = DesignSystemFontFamily.Suit.medium.font(size: 12)
        $0.setUnderline()
    }
    
    
    override func viewDidLoad() {
        view.backgroundColor = DesignSystemAsset.Colors.bottomSheet.color
        addView()
        setLayout()
    }
    
    private func addView() {
        view.addSubviews(allAgreeWrapperButton, separatorLine,
                         termsOfUseWrapperButton, personalInformationWrapperButton)
        allAgreeWrapperButton.addSubviews(allAgreeChildButton, allAgreeChildLabel)
        termsOfUseWrapperButton.addSubviews(termsOfUseChildImageView, termsOfUseChileLabel,
                                            termsOfUseSeeMoreButton)
        personalInformationWrapperButton.addSubviews(personalInformationChildImageView,
                                                     personalInformationChildLabel,
                                                     personalInformationSeeMoreButton)
    }
    
    private func setLayout() {
        allAgreeWrapperButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(58)
            $0.leading.equalToSuperview().inset(35)
        }
        
        allAgreeChildButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        allAgreeChildLabel.snp.makeConstraints {
            $0.centerY.equalTo(allAgreeChildButton)
            $0.leading.equalTo(allAgreeChildButton.snp.trailing).offset(13)
        }
        
        separatorLine.snp.makeConstraints {
            $0.top.equalTo(allAgreeWrapperButton.snp.bottom).offset(17)
            $0.leading.trailing.equalToSuperview().inset(33)
            $0.height.equalTo(1)
        }
        
        termsOfUseWrapperButton.snp.makeConstraints {
            $0.top.equalTo(separatorLine.snp.bottom).offset(23)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        termsOfUseChildImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        termsOfUseChileLabel.snp.makeConstraints {
            $0.centerY.equalTo(termsOfUseChildImageView)
            $0.leading.equalTo(termsOfUseChildImageView.snp.trailing).offset(13)
        }
        
        termsOfUseSeeMoreButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.centerY.equalTo(termsOfUseChileLabel)
        }
        
        personalInformationWrapperButton.snp.makeConstraints {
            $0.top.equalTo(termsOfUseWrapperButton.snp.bottom).offset(38)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        personalInformationChildImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        personalInformationChildLabel.snp.makeConstraints {
            $0.centerY.equalTo(personalInformationChildImageView)
            $0.leading.equalTo(personalInformationChildImageView.snp.trailing).offset(13)
        }
        
        personalInformationSeeMoreButton.snp.makeConstraints {
            $0.centerY.equalTo(personalInformationChildLabel)
            $0.top.trailing.equalToSuperview()
        }
    }
}
