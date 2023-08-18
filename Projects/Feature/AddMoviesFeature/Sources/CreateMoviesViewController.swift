import UIKit
import BaseFeature
import SnapKit
import Then
import DesignSystem
import Utility
import RxSwift
import RxCocoa

enum MovieDescriptionText {
    static var placeHolder = "소개글을 입력해 주세요."
}

public class CreateMoviesViewController: BaseVC<CreateMoviesViewModel>,
                                  RemoveCollectionViewCellHandlerProtocol {
    private let addOtherImageBehaviorRelay = BehaviorRelay<[UIImage]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    private let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private let thumbnailTitleLabel = UILabel().then {
        $0.text = "썸네일"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 16)
    }
    
    private let thumbnailWrapperView = UIView().then {
        $0.backgroundColor = DesignSystemAsset.Colors.darkgray3.color
        $0.layer.cornerRadius = 20
    }
    
    private let thumbnailDescriptionLabel = UILabel().then {
        $0.text = "썸네일을 등록해 주세요."
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.semiBold.font(size: 16)
    }
    
    private let thumbnailImageUploadButton = BasePaddingButton(padding: UIEdgeInsets(
        top: 3,
        left: 12,
        bottom: 3,
        right: 12
    )).then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.backgroundColor = DesignSystemAsset.Colors.mainColor.color
        $0.setTitle("+ 이미지 업로드", for: .normal)
    }
    
    private let movieTitleLabel = UILabel().then {
        $0.text = "영화"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 16)
    }
    
    private let movieRegisterButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = DesignSystemAsset.Colors.darkgray3.color
    }
    
    private let movieRegisterIcon = UIImageView().then {
        $0.image = DesignSystemAsset.Images.registMovie.image
        $0.tintColor = .white
    }
    
    private let movieRegisterText = UILabel().then {
        $0.textColor = DesignSystemAsset.Colors.gray.color
        $0.text = "영화를 등록해 주세요."
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 14)
    }
    
    private let subjectTitleLabel = UILabel().then {
        $0.text = "제목"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 16)
    }
    
    private let subjectTextField = TextFieldBoxComponent().then {
        $0.setPlaceholer(text: "제목을 입력해 주세요.")
    }
    
    private let descriptionTitleLabel = UILabel().then {
        $0.text = "소개"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 16)
    }
    
    private let descriptionTextView = UITextView().then {
        $0.text = MovieDescriptionText.placeHolder
        $0.textColor = DesignSystemAsset.Colors.gray.color
        $0.textContainerInset = UIEdgeInsets(top: 17, left: 13, bottom: 0, right: 0)
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 14)
        $0.layer.cornerRadius = 10
        $0.backgroundColor = DesignSystemAsset.Colors.darkgray3.color
    }
    
    private let fundingTitleLabel = UILabel().then {
        $0.text = "펀딩 여부"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.medium.font(size: 14)
    }
    
    private let fundingTextLabel = TextFieldBoxComponent().then {
        $0.text = MovieDescriptionText.placeHolder
        $0.textColor = .white
    }
    
    private let fundingSwitch = UISwitch().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = $0.bounds.height / 2
        $0.onTintColor = DesignSystemAsset.Colors.mainColor.color
    }
    
    private let otherImageTitleLabel = UILabel().then {
        $0.text = "추가 이미지"
        $0.textColor = .white
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 16)
    }
    
    private let addOtherImageButton = UIButton().then {
        $0.titleLabel?.font = DesignSystemFontFamily.Suit.medium.font(size: 25)
        $0.setTitle("+", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 30
        $0.backgroundColor = DesignSystemAsset.Colors.darkgray3.color
    }
    
    private let imagePicker = UIImagePickerController().then {
        $0.sourceType = .photoLibrary
        $0.allowsEditing = true
    }
    
    lazy var addOtherImageCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .black
        view.register(AddOtherFundingImageCell.self, forCellWithReuseIdentifier: AddOtherFundingImageCell.identifier)
        return view
    }()
    
    private let continueButton = ButtonComponent().then {
        $0.setTitle("계속하기", for: .normal)
    }
    
    public override func configureVC() {
        navigationController?.navigationBar.prefersLargeTitles = false
        addOtherImageCollectionView.delegate = self
        
        descriptionTextView.delegate = self
        imagePicker.delegate = self
        
        addOtherImageButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.present(owner.imagePicker, animated: true)
            }.disposed(by: disposeBag)
        
        addOtherImageBehaviorRelay
            .asDriver()
            .drive(addOtherImageCollectionView.rx.items(
                cellIdentifier: AddOtherFundingImageCell.identifier,
                cellType: AddOtherFundingImageCell.self)) { row, data, cell in
                    cell.delegate = self
                    cell.configure(image: data)
                    cell.setRowIdx(row: row)
                }.disposed(by: disposeBag)
    }
    
    public override func addView() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubviews(
            thumbnailTitleLabel, thumbnailWrapperView,
            movieTitleLabel, movieRegisterButton,
            subjectTitleLabel, subjectTextField,
            descriptionTitleLabel, descriptionTextView,
            fundingTitleLabel, fundingTextLabel,
            continueButton, otherImageTitleLabel,
            addOtherImageButton, addOtherImageCollectionView
        )
        
        thumbnailWrapperView.addSubviews(
            thumbnailDescriptionLabel, thumbnailImageUploadButton
        )
        
        movieRegisterButton.addSubviews(
            movieRegisterIcon, movieRegisterText
        )
        
        fundingTextLabel.addSubview(fundingSwitch)
    }
    
    public override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.bottom.width.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        thumbnailTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(29)
            $0.leading.equalToSuperview().inset(15)
        }
        
        thumbnailWrapperView.snp.makeConstraints {
            $0.top.equalTo(thumbnailTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        
        thumbnailDescriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(36)
            $0.centerX.equalToSuperview()
        }
        
        thumbnailImageUploadButton.snp.makeConstraints {
            $0.top.equalTo(thumbnailDescriptionLabel.snp.bottom).offset(26)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(29)
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailWrapperView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(15)
        }
        
        movieRegisterButton.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(54)
        }
        
        movieRegisterIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(13)
            $0.width.equalTo(20)
            $0.height.equalTo(12)
        }
        
        movieRegisterText.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(movieRegisterIcon.snp.trailing).offset(8)
        }
        
        subjectTitleLabel.snp.makeConstraints {
            $0.top.equalTo(movieRegisterButton.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(15)
        }
        
        subjectTextField.snp.makeConstraints {
            $0.top.equalTo(subjectTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(54)
        }
        
        descriptionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(subjectTextField.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(15)
        }
        
        descriptionTextView.snp.makeConstraints {
            $0.top.equalTo(descriptionTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(80)
        }
        
        fundingTitleLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionTextView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(15)
        }
        
        fundingTextLabel.snp.makeConstraints {
            $0.top.equalTo(fundingTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(54)
        }
        
        fundingSwitch.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(13)
        }
        
        otherImageTitleLabel.snp.makeConstraints {
            $0.top.equalTo(fundingTextLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(15)
        }
        
        addOtherImageButton.snp.makeConstraints {
            $0.top.equalTo(otherImageTitleLabel.snp.bottom).offset(37)
            $0.leading.equalToSuperview().inset(15)
            $0.size.equalTo(60)
        }
        
        addOtherImageCollectionView.snp.makeConstraints {
            $0.top.equalTo(otherImageTitleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(addOtherImageButton.snp.trailing).offset(12)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(105)
        }
        
        continueButton.snp.makeConstraints {
            $0.top.equalTo(addOtherImageButton.snp.bottom).offset(57)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(79)
            $0.height.equalTo(54)
        }
    }
}

extension CreateMoviesViewController: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == MovieDescriptionText.placeHolder {
            textView.text = ""
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = MovieDescriptionText.placeHolder
            textView.textColor = .lightGray
        }
    }
}

extension CreateMoviesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage? = nil
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage
        }
        
        var value = addOtherImageBehaviorRelay.value
        value.append(newImage!)
        addOtherImageBehaviorRelay.accept(value)
        
        picker.dismiss(animated: true, completion: nil)
    }
}

extension CreateMoviesViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 162, height: collectionView.frame.height)
    }
}

extension CreateMoviesViewController {
    func removeImageButtonDidTap(index: Int) {
        var value = addOtherImageBehaviorRelay.value
        value.remove(at: index)
        addOtherImageBehaviorRelay.accept(value)
    }
}
