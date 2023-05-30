import BaseFeature
import UIKit
import DesignSystem
import RxSwift
import RxCocoa
import Utility

class SignupProfileImageViewController: BaseVC<SignupProfileImageViewModel> {
    private let inputProfileImageButton = UIButton()
    
    private let symbolImageView = UIImageView().then {
        $0.image = DesignSystemAsset.Images.photo.image
        $0.tintColor = DesignSystemAsset.Colors.textBox.color
    }
    
    private let backgroundCircleView = UIButton().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 62.5
        $0.backgroundColor = DesignSystemAsset.Colors.exampleText.color
    }
    
    private let smallBackgroundCircleView = UIButton().then {
        $0.setTitle("+", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        $0.setTitleColor(.white, for: .normal)
        $0.isEnabled = false
        $0.layer.cornerRadius = 20
        $0.backgroundColor = DesignSystemAsset.Colors.plusButton.color
    }
    
    private let continueButton = ButtonComponent().then {
        $0.setTitle("계속하기", for: .normal)
    }
    
    override func configureVC() {
        title = "사용하실\n이미지를 넣어 주세요."
    }
    
    override func addView() {
        view.addSubviews(inputProfileImageButton, continueButton)
        inputProfileImageButton.addSubviews(backgroundCircleView, smallBackgroundCircleView)
        backgroundCircleView.addSubview(symbolImageView)
    }
    
    override func setLayout() {
        inputProfileImageButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(54)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(137)
            $0.height.equalTo(125)
        }
        
        symbolImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(55)
        }
        
        backgroundCircleView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.size.equalTo(125)
        }
        
        smallBackgroundCircleView.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        continueButton.snp.makeConstraints {
            $0.top.equalTo(inputProfileImageButton.snp.bottom).offset(156)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
    }
}
