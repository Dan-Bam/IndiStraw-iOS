import UIKit
import BaseFeature

class AddressViewController: BaseVC<AddressViewModel> {
    private let searchController = UISearchBar().then {
        $0.showsCancelButton = false
        $0.searchTextField.borderStyle = .none
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.cornerRadius = 5
        $0.placeholder = "검색어를 입력해주세요."
    }
    override func configureVC() {
        navigationItem.titleView = searchController
    }
}
