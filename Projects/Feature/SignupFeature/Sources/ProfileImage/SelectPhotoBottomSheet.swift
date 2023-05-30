import UIKit

class SelectPhotoBottomSheet: UIViewController {
    private let photoImageView = UIImageView().then {
        $0.image = .init(systemName: "photo")?.withTintColor(.white)
    }
    
    private let selectionPhotoLabel = UILabel().then {
        $0.text = "갤러리에서 선택"
        $0.textColor = .white
    }
    
    private let selectionPhotoButton = UIButton()
    
    private let cameraImageView = UIImageView().then {
        $0.image = .init(systemName: "camera")?.withTintColor(.white)
    }
    
    private let selectionCameraLabel = UILabel().then {
        $0.text = "사진 찍기"
        $0.textColor = .white
    }
    
    private let selectionCameraButton = UIButton()
    
    override func viewDidLoad() {
        addView()
        setLayout()
    }
    
    private func addView() {
        view.addSubviews(selectionPhotoButton, selectionCameraButton)
        selectionPhotoButton.addSubviews(photoImageView, selectionPhotoLabel)
        selectionCameraButton.addSubviews(cameraImageView, selectionCameraLabel)
    }
    
    private func setLayout() {
        selectionPhotoButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(58)
            $0.leading.equalToSuperview().inset(27)
        }
        
        photoImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
        
        selectionPhotoLabel.snp.makeConstraints {
            $0.leading.equalTo(photoImageView.snp.trailing).offset(16)
        }
        
        selectionCameraButton.snp.makeConstraints {
            $0.top.equalTo(selectionPhotoButton.snp.bottom).offset(36)
            $0.leading.equalTo(selectionPhotoButton.snp.leading)
        }
        
        cameraImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
        
        selectionCameraLabel.snp.makeConstraints {
            $0.leading.equalTo(cameraImageView.snp.trailing).offset(16)
        }
    }
}
