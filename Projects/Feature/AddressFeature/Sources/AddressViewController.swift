import UIKit
import BaseFeature

class AddressViewController: BaseVC<AddressViewModel> {
//    private let searchController = UISearchController().then {
//        $0.searchBar.placeholder = "검색어를 입력해주세요."
//        $0.searchBar.layer.borderWidth = 1
//        $0.searchBar.layer.borderColor = UIColor.white.cgColor
//        $0.searchBar.layer.cornerRadius = 5
//    }
    
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

    override func configureVC() {
        navigationItem.titleView = searchTextField
    }
    
    override func addView() {
        view.addSubviews(searchTextField)
    }
    
    override func setLayout() {
        searchTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(55)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(308)
            $0.height.equalTo(40)
        }
    }
}
