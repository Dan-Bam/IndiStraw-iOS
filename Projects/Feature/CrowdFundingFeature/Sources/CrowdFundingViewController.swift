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
    
    override func configureVC() {

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
            fundingTitleLabel
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
    }
}

extension CrowdFundingViewController {
    func prepare(model: CrowdFundingDetailResponse) {
        fundingImageView.kf.setImage(with: URL(string: model.thumbnailUrl))
        writerLabel.text = model.writer.name
        fundingTitleLabel.text = model.title
    }
}
