import UIKit
import BaseFeature
import DesignSystem
import SnapKit
import Then
import RxSwift
import RxCocoa

public class FindIdViewController: BaseVC<FindIdViewModel> {
    private let disposeBag = DisposeBag()
    
    private let inputIdTextField = TextFieldBoxComponent().then {
        $0.isEnabled = false
    }
    
    private let confirmButton = ButtonComponent().then {
        $0.setTitle("확인하기", for: .normal)
    }
    
    var phoneNumber: String
    
    public init(viewModel: FindIdViewModel, phoneNumber: String) {
        self.phoneNumber = phoneNumber
        
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func configureVC() {
        navigationItem.title = "현재 아이디"
        
        viewModel.requestToFindId(phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .success(let data):
                self?.inputIdTextField.text = data.id
            default:
                self?.inputIdTextField.text = "아이디 찾기를 실패했습니다."
            }
        }
        
        confirmButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.viewModel.popToRootVC()
            }.disposed(by: disposeBag)
        
    }
    
    public override func addView() {
        view.addSubviews(inputIdTextField, confirmButton)
    }
    
    public override func setLayout() {
        inputIdTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(96)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(inputIdTextField.snp.bottom).offset(78)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
    }
}
