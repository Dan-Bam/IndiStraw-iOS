import BaseFeature
import UIKit
import DesignSystem
import RxSwift
import RxCocoa
import Utility

class SignupProfileImageViewController: BaseVC<SignupProfileImageViewModel>, SelectPhotoProtocol {
    private let disposeBag = DisposeBag()
    
    private let inputProfileImageButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Images.inputPhoto.image, for: .normal)
    }
    
    private let continueButton = ButtonComponent().then {
        $0.setTitle("계속하기", for: .normal)
    }
    
    private let imagePickerController = UIImagePickerController()
    
    // MARK: - Method
    
    func selectionPhotoButtonDidTap() {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.modalPresentationStyle = .fullScreen
        
        self.dismiss(animated: false)
        self.present(self.imagePickerController, animated: true)

    }
    
    override func configureVC() {
        title = "사용하실\n이미지를 넣어 주세요."
        
        imagePickerController.delegate = self

        inputProfileImageButton.rx.tap
            .bind(with: self) { owner, _ in
                let vc = SelectPhotoBottomSheet(delegate: self)
                vc.modalPresentationStyle = .pageSheet
                if let sheet = vc.sheetPresentationController {
                    sheet.detents = [.medium(), .large()]
                    sheet.prefersGrabberVisible = true
                }
                owner.present(vc, animated: true)
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

extension SignupProfileImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage? = nil
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage
        }
        self.inputProfileImageButton.setImage(newImage, for: .normal)
        
        picker.dismiss(animated: true, completion: nil)
    }
}
