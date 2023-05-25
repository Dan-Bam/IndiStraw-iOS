import UIKit
import BaseFeature

public class SigninViewController: BaseVC<SigninViewModel> {
    public override func configureVC() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "로그인 하기"
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        view.backgroundColor = .black
    }
}
