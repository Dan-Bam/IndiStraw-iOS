import UIKit
import BaseFeature
import Utility
import DesignSystem

public class SigninViewController: BaseVC<SigninViewModel> {
    private let inputIDTextField = TextFieldBox().then {
        $0.placeholder = "아이디"
        $0.eyeIconButtonVisible()
    }
    
    public override func configureVC() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "로그인 하기"
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        view.backgroundColor = .black
    }
    
    public override func addView() {
        view.addSubviews(inputIDTextField)
    }
    
    public override func setLayout() {
        inputIDTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(150)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
    }
}
