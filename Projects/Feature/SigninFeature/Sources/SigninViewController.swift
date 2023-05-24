import UIKit
import BaseFeature

public class SigninViewController: BaseVC<SigninViewModel> {
    public override func configureVC() {
        navigationItem.title = "로그인 하기"
        view.backgroundColor = .red
    }
}
