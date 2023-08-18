import UIKit
import BaseFeature
import SnapKit
import Then
import DesignSystem
import RxSwift
import RxCocoa

public class DetailAddressViewController: BaseVC<DetailAddressViewModel> {
    private let disposeBag = DisposeBag()
    
    var zipCode: String
    var roadAddrPart: String
    
    private let nowAddressLabel = UILabel().then {
        $0.text = "현재주소"
        $0.font = DesignSystemFontFamily.Suit.bold.font(size: 24)
        $0.textColor = .white
    }
    
    private let zipCodeLabel = UILabel().then {
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 14)
        $0.textColor = .white
    }
    
    private let roadAddrPartLabel = UILabel().then {
        $0.font = DesignSystemFontFamily.Suit.regular.font(size: 14)
        $0.textColor = .white
    }
    
    private let inputDetailAddressTextField = TextFieldBoxComponent().then {
        $0.setPlaceholer(text: "상세주소")
    }
    
    private let confirmButton = ButtonComponent().then {
        $0.setTitle("확인하기", for: .normal)
    }
    
    public init(viewModel: DetailAddressViewModel, zipCode: String, roadAddrPart: String) {
        self.zipCode = zipCode
        self.roadAddrPart = roadAddrPart
        
        super.init(viewModel: viewModel)
        
        zipCodeLabel.text = zipCode
        roadAddrPartLabel.text = roadAddrPart
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func configureVC() {
        confirmButton.rx.tap
            .bind(with: self) { owner, _ in
                let detailAddress = owner.inputDetailAddressTextField.text!
                owner.viewModel.requestToChangeAddress(
                    data: ChangeAddressModel(
                        zipcode: owner.zipCode,
                        streetAddress: owner.roadAddrPart,
                        detailAddress: detailAddress
                    )
                )
            }.disposed(by: disposeBag)
    }
    
    public override func addView() {
        view.addSubviews(
            nowAddressLabel, zipCodeLabel,
            roadAddrPartLabel, inputDetailAddressTextField,
            confirmButton
        )
    }
    
    public override func setLayout() {
        nowAddressLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(44)
            $0.leading.equalToSuperview().inset(32)
        }
        
        zipCodeLabel.snp.makeConstraints {
            $0.top.equalTo(nowAddressLabel.snp.bottom).offset(16)
            $0.leading.equalTo(nowAddressLabel)
        }
        
        roadAddrPartLabel.snp.makeConstraints {
            $0.top.equalTo(zipCodeLabel.snp.bottom).offset(2)
            $0.leading.equalTo(nowAddressLabel)
        }
        
        inputDetailAddressTextField.snp.makeConstraints {
            $0.top.equalTo(roadAddrPartLabel.snp.bottom).offset(47)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(inputDetailAddressTextField.snp.bottom).offset(44)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
    }
}
