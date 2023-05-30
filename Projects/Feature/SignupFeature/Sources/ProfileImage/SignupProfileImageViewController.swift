import BaseFeature
import UIKit
import DesignSystem
import RxSwift
import RxCocoa
import Utility

class SignupProfileImageViewController: BaseVC<SignupProfileImageViewModel> {
    private let disposeBag = DisposeBag()
    
    private let inputProfileImageButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Images.inputPhoto.image, for: .normal)
    }
    
    private let continueButton = ButtonComponent().then {
        $0.setTitle("계속하기", for: .normal)
    }
    
    // MARK: - Method
    
    override func configureVC() {
        title = "사용하실\n이미지를 넣어 주세요."
        
        inputProfileImageButton.rx.tap
            .bind(with: self) { owner, _ in
                print("asfdasf")
                owner.viewModel.presentSelectPhotoSheet()
            }.disposed(by: disposeBag)
    }
    
    override func addView() {
        view.addSubviews(inputProfileImageButton, continueButton)
    }
    
    override func setLayout() {
        inputProfileImageButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(54)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(137)
            $0.height.equalTo(125)
        }
        
        continueButton.snp.makeConstraints {
            $0.top.equalTo(inputProfileImageButton.snp.bottom).offset(156)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
    }
}
