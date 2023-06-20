import UIKit
import BaseFeature
import SelectPhotoFeature
import DesignSystem

class EditProfileViewController: BaseVC<EditProfileViewModel>, presentBottomSheetProtocol, SelectPhotoProtocol {
    func presentBottomSheet() {
        let vc = SelectPhotoBottomSheet(delegate: self)
        vc.modalPresentationStyle = .pageSheet
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        present(vc, animated: true)
    }
    
    private let component = SelectPhotoViewButton()
    
    var isImageChanged = false
    
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
        component.delegate = self
        imagePickerController.delegate = self
    }
    
    override func addView() {
        view.addSubviews(component)
    }
    
    override func setLayout() {
        component.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(22)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(137)
            $0.height.equalTo(125)
        }
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
