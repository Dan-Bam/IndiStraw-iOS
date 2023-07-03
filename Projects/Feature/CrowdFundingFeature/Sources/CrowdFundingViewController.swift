import UIKit
import BaseFeature
import SnapKit
import Then
import DesignSystem
import RxSwift
import RxCocoa
import Kingfisher

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
    
    private let remainingDayLabel = UIButton().then {
        $0.isEnabled = false
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.setTitleColor(DesignSystemAsset.Colors.purple2.color, for: .normal)
        $0.titleLabel?.font = DesignSystemFontFamily.Suit.regular.font(size: 12)
        $0.backgroundColor = DesignSystemAsset.Colors.mainColor.color
    }
    
    private let totalAmountLabel = UILabel().then {
        $0.textColor = .white
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
            remainingDayLabel, totalAmountLabel
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
            $0.width.equalTo(54)
            $0.height.equalTo(17)
        }
        
        totalAmountLabel.snp.makeConstraints {
            $0.top.equalTo(remainingDayLabel.snp.bottom).offset(8)
            $0.leading.equalTo(fundingTitleLabel)
        }
    }
}

extension CrowdFundingViewController {
    func prepare(model: CrowdFundingDetailResponse) {
        fundingImageView.kf.setImage(with: URL(string: model.thumbnailUrl))
        writerLabel.text = "진행자: " + model.writer.name
        fundingTitleLabel.text = model.title
        achivementPercentageLabel.text = "\(model.amount.percentage)" + "%" + " 달성"
        setPercentageTextFont(percentage: model.amount.percentage)
        remainingDayLabel.setTitle("\(model.remainingDay)" + "일 남음", for: .normal)
        totalAmountLabel.text = "\(model.amount.totalAmount)" + "/" + "\(model.amount.targetAmount)" + "원 달성"
        setTotalAmountTextFont(totalAmount: model.amount.totalAmount, targetAmount: model.amount.targetAmount)
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
    
    private func setTotalAmountTextFont(totalAmount: Float, targetAmount: Float) {
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
