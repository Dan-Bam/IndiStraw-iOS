import UIKit
import BaseFeature
import SelectPhotoFeature
import DesignSystem
import RxSwift
import RxCocoa

class EditProfileViewController: BaseVC<EditProfileViewModel>, presentBottomSheetProtocol, SelectPhotoProtocol {
    private let disposeBag = DisposeBag()
    
    private let component = SelectPhotoViewButton()
    
    var isImageChanged = false
    
    private let imagePickerController = UIImagePickerController()
    
    private let inputNameTextField = TextFieldBox().then {
        $0.setPlaceholer(text: "이름")
    }
    
    private let inputPhoneNumberTextField = TextFieldBox().then {
        $0.isEnabled = false
        $0.setPlaceholer(text: "전화번호")
    }
    
    private let phoneNumberChangeButton = UIButton().then {
        $0.titleLabel?.font = DesignSystemFontFamily.Suit.medium.font(size: 12)
        $0.setTitle("변경하기", for: .normal)
        $0.setTitleColor(DesignSystemAsset.Colors.skyblue.color, for: .normal)
    }
    
    private let inputAddressTextField = TextFieldBox().then {
        $0.isEnabled = false
        $0.setPlaceholer(text: "주소")
    }
    
    private let addressChangeButton = UIButton().then {
        $0.titleLabel?.font = DesignSystemFontFamily.Suit.medium.font(size: 12)
        $0.setTitle("주소찾기", for: .normal)
        $0.setTitleColor(DesignSystemAsset.Colors.skyblue.color, for: .normal)
    }
    
    private let saveButton = ButtonComponent().then {
        $0.setTitle("저장하기", for: .normal)
    }
    
    // MARK: - Method
    override func configureVC() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        component.delegate = self
        imagePickerController.delegate = self
        
        phoneNumberChangeButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.viewModel.pushChangePhoneNumber()
            }.disposed(by: disposeBag)
        
        addressChangeButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.viewModel.pushFindAddress()
            }.disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.requestProfileInfo() { [weak self] result in
            switch result {
            case .success(let data):
                self?.inputNameTextField.text = data.name
                self?.inputPhoneNumberTextField.text = data.phoneNumber
                self?.inputAddressTextField.text = data.address
            case .failure:
                print("Error")
            }
        }
        
        saveButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.viewModel.requestToeditProfile(name: owner.inputNameTextField.text!)
            }.disposed(by: disposeBag)
    }
    
    override func addView() {
        view.addSubviews(
            component, inputNameTextField,
            inputPhoneNumberTextField, inputAddressTextField,
            phoneNumberChangeButton, addressChangeButton,
            saveButton
        )
    }
    
    override func setLayout() {
        component.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(22)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(137)
            $0.height.equalTo(125)
        }
        
        inputNameTextField.snp.makeConstraints {
            $0.top.equalTo(component.snp.bottom).offset(56)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        inputPhoneNumberTextField.snp.makeConstraints {
            $0.top.equalTo(inputNameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        phoneNumberChangeButton.snp.makeConstraints {
            $0.centerY.equalTo(inputPhoneNumberTextField)
            $0.trailing.equalTo(inputPhoneNumberTextField.snp.trailing).offset(-10)
        }
        
        inputAddressTextField.snp.makeConstraints {
            $0.top.equalTo(inputPhoneNumberTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        addressChangeButton.snp.makeConstraints {
            $0.centerY.equalTo(inputAddressTextField)
            $0.trailing.equalTo(inputAddressTextField.snp.trailing).offset(-10)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(inputAddressTextField.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
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

extension EditProfileViewController {
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
    
    func presentBottomSheet() {
        let vc = SelectPhotoBottomSheet(delegate: self)
        vc.modalPresentationStyle = .pageSheet
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        present(vc, animated: true)
    }
}
