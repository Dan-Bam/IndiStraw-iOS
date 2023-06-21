import UIKit
import BaseFeature
import RxSwift
import RxCocoa

class AddressViewController: BaseVC<AddressViewModel> {
//    private let searchController = UISearchController().then {
//        $0.searchBar.placeholder = "검색어를 입력해주세요."
//        $0.searchBar.layer.borderWidth = 1
//        $0.searchBar.layer.borderColor = UIColor.white.cgColor
//        $0.searchBar.layer.cornerRadius = 5
//    }
    
    private let disposeBag = DisposeBag()
    
    private let searchTextField = UITextField().then {
        $0.placeholder = "검색어를 입력해주세요."
        $0.textColor = .white
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.white.cgColor
        $0.attributedPlaceholder = NSAttributedString(
            string: $0.placeholder!,
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        $0.addLeftPadding()
    }
    
    private let searchButton = UIButton().then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = .white
    }

    override func configureVC() {
        navigationItem.titleView = searchTextField
        
        searchTextField.rx.controlEvent(.editingChanged)
            .bind(with: self) { owner, _ in
                let keyword = owner.searchTextField.text!
                owner.viewModel.requestAddress(keyword: keyword)
            }.disposed(by: disposeBag)
        
        searchButton.rx.tap
            .bind(with: self) { owner, _ in
                
            }.disposed(by: disposeBag)
    }
    
    override func addView() {
        view.addSubviews(searchTextField)
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
    }
}
