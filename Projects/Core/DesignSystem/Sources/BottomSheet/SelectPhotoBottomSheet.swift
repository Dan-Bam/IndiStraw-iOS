import UIKit
import RxSwift
import RxCocoa

public protocol SelectPhotoProtocol: AnyObject {
    func selectionPhotoBottomSheetButtonDidTap(type: PhotoType)
}

public class SelectPhotoBottomSheet: UIViewController {
    weak var delegate: SelectPhotoProtocol?
    
    private let disposeBag = DisposeBag()
    
    private let photoImageView = UIImageView().then {
        $0.image = UIImage(systemName: "photo")
        $0.tintColor = .white
        $0.sizeToFit()
    }
    
    private let selectionPhotoLabel = UILabel().then {
        $0.text = "갤러리에서 선택"
        $0.textColor = .white
    }
    
    private let selectionPhotoButton = UIButton()
    
    private let cameraImageView = UIImageView().then {
        $0.image = .init(systemName: "camera")
        $0.tintColor = .white
        $0.sizeToFit()
    }
    
    private let selectionCameraLabel = UILabel().then {
        $0.text = "사진 찍기"
        $0.textColor = .white
    }
    
    private let selectionCameraButton = UIButton()
    
    public init(delegate: any SelectPhotoProtocol) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        view.backgroundColor = DesignSystemAsset.Colors.bottomSheet.color
        addView()
        setLayout()
        
        selectionPhotoButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.delegate?.selectionPhotoBottomSheetButtonDidTap(type: .photo)
            }.disposed(by: disposeBag)
        
        selectionCameraButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.delegate?.selectionPhotoBottomSheetButtonDidTap(type: .camera)
            }.disposed(by: disposeBag)
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
            $0.size.equalTo(30)
        }
        
        selectionPhotoLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(photoImageView.snp.trailing).offset(16)
            $0.centerY.equalTo(photoImageView)
        }
        
        selectionCameraButton.snp.makeConstraints {
            $0.top.equalTo(selectionPhotoButton.snp.bottom).offset(36)
            $0.leading.equalTo(selectionPhotoButton.snp.leading)
        }
        
        cameraImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.size.equalTo(30)
        }
        
        selectionCameraLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(cameraImageView.snp.trailing).offset(16)
            $0.centerY.equalTo(cameraImageView)
        }
    }
}
