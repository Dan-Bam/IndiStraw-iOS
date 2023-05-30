import BaseFeature
import UIKit
import DesignSystem
import RxSwift
import RxCocoa
import Utility

class SignupProfileImageViewController: BaseVC<SignupProfileImageViewModel> {
    private let inputProfileImageButton = UIButton()
    
    private let backgroundCircleView = UIView().then {
        $0.layer.cornerRadius = 125
        $0.backgroundColor = DesignSystemAsset.exampleText.color
    }
    
    private let smallBackgroundCircleView = UIView().then {
        $0.layer.cornerRadius = 45
        $0.backgroundColor = DesignSystemAsset.pl.color
    }
    
    override func configureVC() {
        title = "사용하실\n이미지를 넣어 주세요."
    }
    
    override func addView() {
        view.addSubviews(inputProfileImageButton)
        inputProfileImageButton.addSubviews(backgroundCircleView, )
    }
    
    override func setLayout() {
        inputProfileImageButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(54)
            $0.leading.trailing.equalToSuperview().inset(59)
            $0.height.equalTo(125)
        }
    }
}
