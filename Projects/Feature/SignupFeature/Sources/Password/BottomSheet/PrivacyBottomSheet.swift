import UIKit
import SnapKit
import Then
import DesignSystem
import Utility
import RxSwift
import RxCocoa

protocol AllAgreeButtonDidTapProtocol: AnyObject {
    func allAgreeButtonDidTap()
}

enum Colors {
    static let mainColor = DesignSystemAsset.Colors.mainColor.color
    static let exampleTextColor = DesignSystemAsset.Colors.exampleText.color
}

class PrivacyBottomSheet: UIViewController {
    weak var delegate: AllAgreeButtonDidTapProtocol?
    
    private let disposeBag = DisposeBag()
    
    private let allAgreeWrapperButton = UIButton()
    
    private let allAgreeChildButton = UIButton().then {
        $0.isEnabled = false
        $0.layer.borderColor = DesignSystemAsset.Colors.exampleText.color.cgColor
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 5
        $0.tintColor = Colors.mainColor
    }
    
    private let allAgreeChildLabel = UILabel().then {
        $0.text = "전체동의"
        $0.textColor = .white
    }
    
    private let separatorLine = UIView().then {
        $0.backgroundColor = DesignSystemAsset.Colors.line.color
    }
    
    private let termsOfUseWrapperButton = UIButton()
    
    private let termsOfUseChildImageView = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark")
        $0.tintColor = Colors.exampleTextColor
    }
     
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
        $0.image = UIImage(systemName: "checkmark")
        $0.tintColor = Colors.exampleTextColor
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
        
        allAgreeWrapperButton.rx.tap
            .asDriver()
            .map { [weak self] in
                self?.allAgreeWrapperButton.isSelected.toggle()
                return self?.allAgreeWrapperButton.isSelected ?? false
            }
            .drive(with: self) { owner, arg in
                owner.allAgreeChildButton.setImage(arg ? UIImage(systemName: "checkmark") : .none, for: .normal)
                owner.termsOfUseChildImageView.tintColor = arg ? Colors.mainColor : Colors.exampleTextColor
                owner.personalInformationChildImageView.tintColor = arg ? Colors.mainColor : Colors.exampleTextColor
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    owner.delegate?.allAgreeButtonDidTap()
                }
            }.disposed(by: disposeBag)
        
        
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
            $0.trailing.equalToSuperview()
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
            $0.trailing.equalToSuperview()
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
            $0.trailing.equalToSuperview()
        }
        
        personalInformationSeeMoreButton.snp.makeConstraints {
            $0.centerY.equalTo(personalInformationChildLabel)
            $0.top.trailing.equalToSuperview()
        }
    }
}
