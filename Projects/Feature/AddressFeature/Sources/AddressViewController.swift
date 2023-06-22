import UIKit
import BaseFeature
import RxSwift
import RxCocoa

class AddressViewController: BaseVC<AddressViewModel> {
    private let disposeBag = DisposeBag()
    
    private let searchTextField = UITextField().then {
        $0.placeholder = "검색어를 입력해주세요."
        $0.textColor = .white
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.white.cgColor
        $0.backgroundColor = .black
        $0.attributedPlaceholder = NSAttributedString(
            string: $0.placeholder!,
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        $0.addLeftPadding()
    }
    
    private let searchButton = UIButton().then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = .white
    }
    
    private let addressTableView = UITableView().then {
        $0.backgroundColor = .black
        $0.register(AddressCell.self, forCellReuseIdentifier: AddressCell.identifier)
    }
    
    func bind() {
        searchTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .flatMapLatest { [weak self] text -> BehaviorRelay<[Juso]> in
                guard let self = self else { return .init(value: []) }

                let input = AddressViewModel.Input(
                    inputKeyword: Observable.just(text)
                )
                let output = self.viewModel.transform(input: input)

                print("output = \(output.outAddressData.value)")
                return output.outAddressData
            }
            .bind(to: addressTableView.rx.items(
                cellIdentifier: AddressCell.identifier,
                cellType: AddressCell.self)) { (row, data, cell) in
                print("data = \(data)")
                cell.configure(data: data)
            }.disposed(by: disposeBag)
    }
    
    override func configureVC() {
        navigationItem.titleView = searchTextField
        navigationItem.titleView?.backgroundColor = .black
        
        bind()
    }
    
    override func addView() {
        view.addSubviews(searchTextField, addressTableView)
        searchTextField.addSubview(searchButton)
    }
    
    override func setLayout() {
        searchTextField.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(308)
            $0.height.equalTo(40)
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(11)
        }
        
        addressTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
