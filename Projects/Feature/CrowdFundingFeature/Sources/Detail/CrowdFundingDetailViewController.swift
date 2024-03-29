import UIKit
import BaseFeature
import SnapKit
import Then
import DesignSystem
import RxSwift
import RxCocoa
import Kingfisher
import Utility
import RxGesture

enum ContentSizeKey {
    static let key = "contentSize"
}

public class CrowdFundingDetailViewController: BaseVC<CrowdFundingDetailViewModel> {
    var disposeBag = DisposeBag()
    
    var attachmentBehaviorRelay = BehaviorRelay<[String]>(value: [])
    var rewardBehaviorRelay = BehaviorRelay<[Reward]>(value: [])
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
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
    
    private let fundingSeparatorLineView = UIView().then {
        $0.backgroundColor = DesignSystemAsset.Colors.darkGray.color
    }
    
    private let descriptionLabel = UILabel().then {
        $0.textColor = DesignSystemAsset.Colors.lightGray.color
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 14)
    }
    
    private let descriptionImageView = ImageViewPageControlComponent().then {
        $0.layer.cornerRadius = 10
    }
    
    private let attachmentLabel = UILabel().then {
        $0.text = "첨부파일"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 16)
    }
    
    private let attachmentListTableView = UITableView().then {
        $0.backgroundColor = .black
        $0.rowHeight = 30
        $0.register(AttachmentCell.self, forCellReuseIdentifier: AttachmentCell.identifier)
    }
    
    private let descriptionSeparatorLineView = UIView().then {
        $0.backgroundColor = DesignSystemAsset.Colors.darkGray.color
    }
    
    private let rewardTitleLabel = UILabel().then {
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 16)
        $0.textColor = .white
        $0.text = "리워드 종류"
    }
    
    private let rewardListTableView = UITableView().then {
        $0.backgroundColor = .black
        $0.rowHeight = 120
        $0.register(RewardCell.self, forCellReuseIdentifier: RewardCell.identifier)
    }

    private let fundingButton = ButtonComponent().then {
        $0.setTitle("펀딩하기", for: .normal)
    }
    
    public override func configureVC() {
        navigationController?.navigationBar.prefersLargeTitles = false
        attachmentBehaviorRelay
            .asDriver()
            .drive(attachmentListTableView.rx.items(
                cellIdentifier: AttachmentCell.identifier,
                cellType: AttachmentCell.self)) { (row, data, cell) in
                    cell.configure(linkText: data)
                }.disposed(by: disposeBag)
        
        rewardBehaviorRelay
            .asDriver()
            .drive(rewardListTableView.rx.items(
                cellIdentifier: RewardCell.identifier,
                cellType: RewardCell.self)) { (row, data, cell) in
                    cell.configure(model: data)
                }.disposed(by: disposeBag)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        self.attachmentListTableView.addObserver(self, forKeyPath: ContentSizeKey.key, options: .new, context: nil)
        self.rewardListTableView.addObserver(self, forKeyPath: ContentSizeKey.key, options: .new, context: nil)
        
        viewModel.requestCrowdFundingDetailList()
            .observe(on: MainScheduler.instance)
            .bind(with: self) { owner, model in
                owner.attachmentBehaviorRelay.accept(model.imageList)
                owner.rewardBehaviorRelay.accept(model.reward)
                
                owner.configure(model: model)
            }.disposed(by: disposeBag)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        self.attachmentListTableView.removeObserver(self, forKeyPath: ContentSizeKey.key)
        self.rewardListTableView.removeObserver(self, forKeyPath: ContentSizeKey.key)
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == ContentSizeKey.key {
            if object is UITableView {
                attachmentListTableView.snp.updateConstraints {
                    $0.height.equalTo(
                        attachmentListTableView.rowHeight * CGFloat(attachmentBehaviorRelay.value.count)
                    )
                }
                
                rewardListTableView.snp.updateConstraints {
                    $0.height.equalTo(
                        rewardListTableView.rowHeight * CGFloat(rewardBehaviorRelay.value.count)
                    )
                }
            }
        }
    }
    
    public override func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(
            fundingImageView, writerLabel,
            fundingTitleLabel, achivementPercentageLabel,
            remainingDayLabel, totalAmountLabel,
            fundingCountLabel, fundingProgressView,
            fundingSeparatorLineView, descriptionLabel,
            descriptionImageView, attachmentLabel,
            attachmentListTableView, descriptionSeparatorLineView,
            rewardTitleLabel, rewardListTableView,
            fundingButton
        )
    }
    
    public override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.centerX.width.top.bottom.equalToSuperview()
        }
        
        fundingImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(17)
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
        
        fundingSeparatorLineView.snp.makeConstraints {
            $0.top.equalTo(fundingProgressView.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(fundingSeparatorLineView).offset(28)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        
        descriptionImageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        
        attachmentLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionImageView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(14)
        }
        
        attachmentListTableView.snp.makeConstraints {
            $0.top.equalTo(attachmentLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        descriptionSeparatorLineView.snp.makeConstraints {
            $0.top.equalTo(attachmentListTableView.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        rewardTitleLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionSeparatorLineView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(15)
        }
        
        rewardListTableView.snp.makeConstraints {
            $0.top.equalTo(rewardTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        fundingButton.snp.makeConstraints {
            $0.top.equalTo(rewardListTableView.snp.bottom).offset(37)
            $0.bottom.equalToSuperview().inset(61)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(54)
        }
    }
}

extension CrowdFundingDetailViewController {
    func configure(model: CrowdFundingDetailResponse) {
        fundingImageView.kf.setImage(with: URL(string: model.thumbnailUrl))
        writerLabel.text = "진행자: " + model.writer.name
        fundingTitleLabel.text = model.title
        setPercentageTextFont(percentage: (model.amount.percentage == 0) ?
                              "0%" : String(format: "%.2f", model.amount.percentage) + "%")
        remainingDayLabel.text = "D-" + "\(model.remainingDay)"
        setTotalAmountTextFont(totalAmount: model.amount.totalAmount, targetAmount: model.amount.targetAmount)
        
        fundingCountLabel.setTitle("\(model.fundingCount.setMoneyType())", for: .normal)
        fundingProgressView.setProgress(0.7, animated: true)
        fundingProgressView.progress = Float(model.amount.percentage) / 100
        
        descriptionLabel.text = model.description
        descriptionImageView.configure(imageList: model.imageList)
    }
    
    private func setPercentageTextFont(percentage: String) {
        let attributeString = NSMutableAttributedString()
        
        let items: [(text: String, attributes: [NSAttributedString.Key: Any])] = [
            (percentage, [.font: DesignSystemFontFamily.Suit.bold.font(size: 18)]),
            ("%", [.font: DesignSystemFontFamily.Suit.medium.font(size: 12)]),
            ("달성", [.font: DesignSystemFontFamily.Suit.regular.font(size: 14)])
        ]
        
        items.forEach {
            attributeString.append(NSAttributedString(string: $0.text, attributes: $0.attributes))
        }
        
        achivementPercentageLabel.attributedText = attributeString
    }
    
    private func setTotalAmountTextFont(totalAmount: Int, targetAmount: Int) {
        let attributeString = NSMutableAttributedString()
        
        let items: [(text: String, attributes: [NSAttributedString.Key: Any])] = [
            (totalAmount.setMoneyType(),
             [.font: DesignSystemFontFamily.Suit.semiBold.font(size: 18)]),
            ("/", [.font: DesignSystemFontFamily.Suit.light.font(size: 18)]),
            (targetAmount.setMoneyType(),
             [.font: DesignSystemFontFamily.Suit.semiBold.font(size: 18),
              .foregroundColor: DesignSystemAsset.Colors.lightGray.color]),
            ("원", [.font: DesignSystemFontFamily.Suit.regular.font(size: 14),
                   .foregroundColor: UIColor.white])
        ]
        
        items.forEach {
            attributeString.append(NSAttributedString(string: $0.text, attributes: $0.attributes))
        }
        
        totalAmountLabel.attributedText = attributeString
        
    }
}
