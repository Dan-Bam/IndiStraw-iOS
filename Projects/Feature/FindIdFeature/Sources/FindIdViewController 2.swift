import UIKit
import BaseFeature
import DesignSystem
import SnapKit
import Then

class FindIdViewController: BaseVC<FindIdViewModel> {
    private let inputIdTextField = TextFieldBox()
    
    private let confirmButton = ButtonComponent()
    
    override func configureVC() {
        navigationItem.title = "현재 아이디"
        
        let phoneNumber = inputIdTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        viewModel.requestToFindId(phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .success(let data):
                self?.inputIdTextField.text = data.id
            default:
                self?.inputIdTextField.text = "아이디 찾기를 실패했습니다."
            }
        }
    }
    
    override func addView() {
        view.addSubviews(inputIdTextField, confirmButton)
    }
    
    override func setLayout() {
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
