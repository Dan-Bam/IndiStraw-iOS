import BaseFeature
import UIKit
import DesignSystem
import RxSwift
import RxCocoa
import Utility

class SignupProfileImageViewController: BaseVC<SignupProfileImageViewModel>, SelectPhotoProtocol {
    private let disposeBag = DisposeBag()

    private let inputProfileImageButton = UIButton()
    
    private let photoImageButton = UIButton().then {
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = false
        $0.isEnabled = true
        $0.backgroundColor = DesignSystemAsset.Colors.exampleText.color
        $0.setImage(DesignSystemAsset.Images.inputPhoto.image, for: .normal)
        $0.layer.cornerRadius = 62.5
    }
    
    private let plusImageButton = UIButton().then {
        $0.isUserInteractionEnabled = false
        $0.setTitle("+", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 20
        $0.backgroundColor = DesignSystemAsset.Colors.plusButton.color
    }
    
    private let continueButton = ButtonComponent().then {
        $0.setTitle("계속하기", for: .normal)
    }
    
    private let imagePickerController = UIImagePickerController()
    
    // MARK: - Method
    
    func selectionPhotoBottomSheetButtonDidTap(type: PhotoType) {
        switch type {
        case .photo:
            imagePickerController.sourceType = .photoLibrary
        case .camera:
            imagePickerController.sourceType = .camera
        }
        imagePickerController.allowsEditing = true
        imagePickerController.modalPresentationStyle = .fullScreen
        
        self.dismiss(animated: true)
        self.present(imagePickerController, animated: true)
    }
    
    override func configureVC() {
        navigationItem.title = "프로필 이미지를 선택해주세요."
        
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
        
        continueButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.viewModel.pushInputIDVC()
            }.disposed(by: disposeBag)
    }
    
    override func addView() {
        view.addSubviews(inputProfileImageButton, continueButton)
        inputProfileImageButton.addSubviews(photoImageButton, plusImageButton)
        
        view.bringSubviewToFront(inputProfileImageButton)
    }
    
    override func setLayout() {
        inputProfileImageButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(54)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(137)
            $0.height.equalTo(125)
        }
        
        photoImageButton.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.size.equalTo(125)
        }
        
        plusImageButton.snp.makeConstraints {
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

extension SignupProfileImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage? = nil
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage
        }
        self.photoImageButton.setImage(newImage, for: .normal)
        
        picker.dismiss(animated: true, completion: nil)
    }
}
