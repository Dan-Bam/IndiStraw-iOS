import UIKit
import BaseFeature
import SnapKit
import Then
import DesignSystem
import RxSwift
import RxCocoa
import Kingfisher
import Utility

class CrowdFundingViewController: BaseVC<CrowdFundingViewModel> {
    var disposeBag = DisposeBag()
    
    private let fundingImageView = UIImageView().then {
        $0.backgroundColor = .gray
    }
    
    private let writerLabel = UILabel().then {
        $0.textColor = DesignSystemAsset.Colors.lightGray.color
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 12)
    }
    
    private let fundingTitleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 18)
        $0.numberOfLines = 0
    }
    
    private let achivementPercentageLabel = UILabel().then {
        $0.font = DesignSystemFontFamily.Suit.bold.font(size: 18)
        $0.textColor = DesignSystemAsset.Colors.purple2.color
    }
    
    private let remainingDayLabel = BasePaddingLabel(padding: UIEdgeInsets(
        top: 1, left: 6, bottom: 1, right: 6)
    ).then {
        $0.textColor = .white
        $0.isEnabled = false
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 12)
        $0.backgroundColor = DesignSystemAsset.Colors.mainColor.color
    }
    
    private let totalAmountLabel = UILabel().then {
        $0.textColor = .white
    }
    
    private let fundingCountLabel = BasePaddingButton(padding: UIEdgeInsets(
        top: 1, left: 4, bottom: 1, right: 4)
    ).then {
        $0.setImage(UIImage(systemName: "person.fill",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 15)),
                    for: .normal)
        $0.tintColor = .white
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = DesignSystemFontFamily.Suit.regular.font(size: 15)
        $0.isEnabled = false
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.backgroundColor = DesignSystemAsset.Colors.darkGray.color
    }
    
    private let fundingProgressView = UIProgressView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 7
        $0.progress = 0.3
        $0.progressTintColor = DesignSystemAsset.Colors.mainColor.color
        $0.trackTintColor = DesignSystemAsset.Colors.darkgray3.color
    }
    
    private let separatorLineView = UIView().then {
        $0.backgroundColor = DesignSystemAsset.Colors.darkGray.color
    }
    
    private let descriptionLabel = UILabel().then {
        $0.textColor = DesignSystemAsset.Colors.lightGray.color
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 14)
    }
    
    private let descriptionImageView = UIImageView().then {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 10
    }
    
    private let pageControl = UIPageControl().then {
        $0.isUserInteractionEnabled = false
//        $0.setCurrentPageIndicatorImage(
//            DesignSystemAsset.Images.pageControlIndicator.image,
//            forPage: $0.currentPage
//        )
    }
    
    override func configureVC() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.requestCrowdFundingList()
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, arg in
                owner.prepare(model: arg)
            }.disposed(by: disposeBag)
    }
    
    override func addView() {
        view.addSubviews(
            fundingImageView, writerLabel,
            fundingTitleLabel, achivementPercentageLabel,
            remainingDayLabel, totalAmountLabel,
            fundingCountLabel, fundingProgressView,
            separatorLineView, descriptionLabel,
            descriptionImageView, pageControl
        )
    }
    
    override func setLayout() {
        fundingImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(17)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(170)
        }
        
        writerLabel.snp.makeConstraints {
            $0.top.equalTo(fundingImageView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(15)
        }
        
        fundingTitleLabel.snp.makeConstraints {
            $0.top.equalTo(writerLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        
        achivementPercentageLabel.snp.makeConstraints {
            $0.top.equalTo(fundingTitleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(fundingTitleLabel)
        }
        
        remainingDayLabel.snp.makeConstraints {
            $0.centerY.equalTo(achivementPercentageLabel)
            $0.leading.equalTo(achivementPercentageLabel.snp.trailing).offset(10)
        }
        
        totalAmountLabel.snp.makeConstraints {
            $0.top.equalTo(remainingDayLabel.snp.bottom).offset(8)
            $0.leading.equalTo(fundingTitleLabel)
        }
        
        fundingCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(totalAmountLabel)
            $0.leading.equalTo(totalAmountLabel.snp.trailing).offset(12)
        }
        
        fundingProgressView.snp.makeConstraints {
            $0.top.equalTo(fundingCountLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(14)
        }
        
        separatorLineView.snp.makeConstraints {
            $0.top.equalTo(fundingProgressView.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(separatorLineView).offset(28)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        
        descriptionImageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(140)
        }
    }
}

extension CrowdFundingViewController {
    func prepare(model: CrowdFundingDetailResponse) {
        pageControl.numberOfPages = model.imageList.count
        pageControl.currentPage = 0
        
        fundingImageView.kf.setImage(with: URL(string: model.thumbnailUrl))
        writerLabel.text = "진행자: " + model.writer.name
        fundingTitleLabel.text = model.title
//        achivementPercentageLabel.text = "\(model.amount.percentage)" + "%" + " 달성"
        setPercentageTextFont(percentage: model.amount.percentage)
        remainingDayLabel.text = "D-" + "\(model.remainingDay)"
//        totalAmountLabel.text = "\(model.amount.totalAmount)" + "/" + "\(model.amount.targetAmount)" + " 원 달성"
        setTotalAmountTextFont(totalAmount: model.amount.totalAmount, targetAmount: model.amount.targetAmount)
        fundingCountLabel.setTitle("\(model.fundingCount)", for: .normal)
        fundingProgressView.setProgress(0.7, animated: true)
        fundingProgressView.progress = Float(model.amount.percentage) / 100
        
        descriptionLabel.text = model.description
    }
    
    private func setPercentageTextFont(percentage: Int) {
        let attributeString = NSMutableAttributedString()
        let amoutPercentageString = NSMutableAttributedString(string: "\(percentage)", attributes: [.font: DesignSystemFontFamily.Suit.bold.font(size: 18)])
        let percentageString = NSMutableAttributedString(string: "%", attributes: [.font: DesignSystemFontFamily.Suit.medium.font(size: 12)])
        let achivementString = NSMutableAttributedString(string: " 달성", attributes: [.font: DesignSystemFontFamily.Suit.regular.font(size: 14)])
        
        attributeString.append(amoutPercentageString)
        attributeString.append(percentageString)
        attributeString.append(achivementString)
        achivementPercentageLabel.attributedText = attributeString
    }
    
    private func setTotalAmountTextFont(totalAmount: Int, targetAmount: Int) {
        let attributeString = NSMutableAttributedString()
        let totalAmountString = NSMutableAttributedString(
            string: "\(totalAmount)",
            attributes: [.font: DesignSystemFontFamily.Suit.semiBold.font(size: 18)]
        )
        let slashString = NSMutableAttributedString(
            string: "/",
            attributes: [.font: DesignSystemFontFamily.Suit.light.font(size: 18)]
        )
        let targetAmountString = NSMutableAttributedString(
            string: "\(targetAmount)",
            attributes: [.font: DesignSystemFontFamily.Suit.semiBold.font(size: 18),
                         .foregroundColor: DesignSystemAsset.Colors.lightGray.color]
        )
        let wonString = NSMutableAttributedString(
            string: "원",
            attributes: [.font: DesignSystemFontFamily.Suit.regular.font(size: 14),
                         .foregroundColor: UIColor.white]
        )
        
        attributeString.append(totalAmountString)
        attributeString.append(slashString)
        attributeString.append(targetAmountString)
        attributeString.append(wonString)
        totalAmountLabel.attributedText = attributeString
    }
}
