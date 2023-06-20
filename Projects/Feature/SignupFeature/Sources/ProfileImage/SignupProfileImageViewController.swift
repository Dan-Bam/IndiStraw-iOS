import BaseFeature
import UIKit
import DesignSystem
import RxSwift
import RxCocoa
import Utility
import SelectPhotoFeature

class SignupProfileImageViewController: BaseVC<SignupProfileImageViewModel>, SelectPhotoProtocol, presentBottomSheetProtocol {
    func presentBottomSheet() {
        let vc = SelectPhotoBottomSheet(delegate: self)
        vc.modalPresentationStyle = .pageSheet
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        present(vc, animated: true)
    }
    
    private let disposeBag = DisposeBag()
    
    private let component = SelectPhotoViewButton()
    
    var isImageChanged = false
    
    private let errorLabel = ErrorLabel()
    
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
        component.delegate = self
        
        continueButton.rx.tap
            .bind(with: self) { owner, _ in
                let image = owner.isImageChanged ? owner.component.photoImageButton.currentImage : nil
                owner.viewModel.pushInputIDVC(image: image)
            }.disposed(by: disposeBag)
    }
    
    override func addView() {
        view.addSubviews(component, continueButton)
    }
    
    override func setLayout() {
        component.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(54)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(137)
            $0.height.equalTo(125)
        }
        
        continueButton.snp.makeConstraints {
            $0.top.equalTo(component.snp.bottom).offset(156)
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
        self.component.photoImageButton.setImage(newImage, for: .normal)
        
        picker.dismiss(animated: true, completion: nil)
        isImageChanged = true
    }
}
