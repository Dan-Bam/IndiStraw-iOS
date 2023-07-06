import UIKit
import DesignSystem
import BaseFeature
import RxSwift
import RxCocoa

class CrowdFundingViewAllViewController: BaseVC<CrowdFundingViewAllViewModel> {
    private let disposeBag = DisposeBag()
    private let crowdFundingListTableView = UITableView()
    
    var fundingListData = BehaviorRelay<[FundingDataList]>(value: [])
    
    override func configureVC() {
        viewModel.requestCrowdFundingList()
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, model in
                owner.fundingListData.accept(model)
            }.disposed(by: disposeBag)
        
        fundingListData
            .asDriver()
            .drive(crowdFundingListTableView.rx.items(
                cellIdentifier: CrowdFundingCell.identifier,
                cellType: CrowdFundingCell.self)) { (row, data, cell) in
                    cell.configure(model: data)
                }.disposed(by: disposeBag)
    }
    
    override func addView() {
        view.addSubview(crowdFundingListTableView)
    }
    
    override func setLayout() {
        crowdFundingListTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
