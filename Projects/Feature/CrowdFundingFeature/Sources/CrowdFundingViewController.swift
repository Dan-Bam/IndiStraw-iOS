import UIKit
import BaseFeature
import SnapKit
import Then
import DesignSystem
import RxSwift
import RxCocoa
import Kingfisher
import Utility

enum ContentSizeKey {
    static let key = "contentSize"
}

class CrowdFundingViewController: BaseVC<CrowdFundingViewModel> {
    var disposeBag = DisposeBag()
    
    var attachmentBehaviorRelay = BehaviorRelay<[String]>(value: [])
    
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
    
    private let descriptionImageView = UIImageView().then {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 10
    }
    
    private let pageControl = UIPageControl().then {
        $0.isUserInteractionEnabled = false
    }
    
    private let attachmentLabel = UILabel().then {
        $0.text = "첨부파일"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 16)
    }
    
    private let attachmentListTableView = UITableView().then {
        $0.backgroundColor = .black
        $0.estimatedRowHeight = 30
        $0.rowHeight = UITableView.automaticDimension
        $0.register(AttachmentCell.self, forCellReuseIdentifier: AttachmentCell.identifier)
    }
    
    private let descriptionSeparatorLineView = UIView().then {
        $0.backgroundColor = DesignSystemAsset.Colors.darkGray.color
    }
    
    override func configureVC() {
        navigationController?.navigationBar.prefersLargeTitles = false
        attachmentBehaviorRelay
            .asDriver()
            .drive(attachmentListTableView.rx.items(
                cellIdentifier: AttachmentCell.identifier,
                cellType: AttachmentCell.self)) { (row, data, cell) in
                    cell.configure(linkText: data)
                }.disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.attachmentListTableView.addObserver(self, forKeyPath: ContentSizeKey.key, options: .new, context: nil)
        
        viewModel.requestCrowdFundingList()
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, arg in
                owner.configure(model: arg)
                owner.attachmentBehaviorRelay.accept(arg.imageList)
            }.disposed(by: disposeBag)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.attachmentListTableView.removeObserver(self, forKeyPath: ContentSizeKey.key)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == ContentSizeKey.key {
            if object is UITableView {
                if let newValue = change?[.newKey] as? CGSize {
                    attachmentListTableView.snp.updateConstraints {
                        $0.height.equalTo(newValue.height + 28)
                    }
                }
            }
        }
    }
    
    override func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(
            fundingImageView, writerLabel,
            fundingTitleLabel, achivementPercentageLabel,
            remainingDayLabel, totalAmountLabel,
            fundingCountLabel, fundingProgressView,
            fundingSeparatorLineView, descriptionLabel,
            descriptionImageView, pageControl,
            attachmentLabel, attachmentListTableView,
            descriptionSeparatorLineView
        )
    }
    
    override func setLayout() {
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
            $0.height.equalTo(140)
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(descriptionImageView.snp.bottom).offset(-8)
        }
        
        attachmentLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionImageView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(14)
        }
        
        attachmentListTableView.snp.makeConstraints {
            $0.top.equalTo(attachmentLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        descriptionSeparatorLineView.snp.makeConstraints {
            $0.top.equalTo(attachmentListTableView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}

extension CrowdFundingViewController {
    func configure(model: CrowdFundingDetailResponse) {
        pageControl.numberOfPages = model.imageList.count
        pageControl.currentPage = 0
        
        fundingImageView.kf.setImage(with: URL(string: model.thumbnailUrl))
        writerLabel.text = "진행자: " + model.writer.name
        fundingTitleLabel.text = model.title
        setPercentageTextFont(percentage: model.amount.percentage)
        remainingDayLabel.text = "D-" + "\(model.remainingDay)"
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
