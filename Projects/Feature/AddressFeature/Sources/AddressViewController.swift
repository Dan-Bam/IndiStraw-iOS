import UIKit
import BaseFeature

class AddressViewController: BaseVC<AddressViewModel> {
    private let searchController = UISearchController()
    override func configureVC() {
        navigationItem.searchController = searchController
    }
}
