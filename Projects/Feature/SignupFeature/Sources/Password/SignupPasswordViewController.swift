import UIKit
import BaseFeature
import DesignSystem
import RxSwift
import RxCocoa

public class SignupPasswordViewController: BaseVC<SignupPasswordViewModel>,
                                           AllAgreeButtonDidTapProtocol, InputPasswordComponentProtocol {
    
    let bottomSheet = PrivacyBottomSheet()
    let component = InputPasswordComponent()
    
    var id: String
    var name: String
    var phoneNumber: String
    var profileImage: UIImage?
    
    public init(
        viewModel: SignupPasswordViewModel,
        id: String,
        name: String,
        phoneNumber: String,
        profileImage: UIImage?
    ) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.profileImage = profileImage
        
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func presentBottomSheet() {
        bottomSheet.modalPresentationStyle = .pageSheet
        if let sheet = bottomSheet.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        present(bottomSheet, animated: true)
    }
    
    func requestToSignup(password: String, data: ProfileImageModel?) {
        viewModel.requestToSignup(
            id: id,
            password: password,
            name: name,
            phoneNumber: phoneNumber,
            profileUrl: data?.imageUrl) { [weak self] result in
                switch result {
                case .success:
                    self?.presentBottomSheet()
                case .failure(.failedRequest):
                    self?.component.changeErrorText(text: "회원가입에 실패했습니다.")
                }
            }
    }
    
    public override func configureVC() {
        navigationItem.title = "비밀번호를 입력해 주세요."
        bottomSheet.delegate = self
        component.delegate = self
    }
    
    public override func addView() {
        view.addSubview(component)
    }
    
    public override func setLayout() {
        component.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension SignupPasswordViewController {
    func allAgreeButtonDidTap() {
        dismiss(animated: true)
        viewModel.popToRootVC()
    }
}

extension SignupPasswordViewController {
    public func isValidPassword(password: String) {
        guard viewModel.isValidPassword(password: password) else {
            component.changeErrorText(text: "숫자와 대소문자, 특수문자를 포함해주세요.")
            component.isValidPassword = false
            return
        }
    }
    
    public func confirmButtonDidTap(password: String) {
        if let image = profileImage {
            viewModel.requestToUploadImage(image: image, password: password) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.requestToSignup(
                        password: password,
                        data: data
                    )
                case .failure:
                    self?.component.changeErrorText(text: "회원가입에 실패했습니다.")
                }
            }
        } else {
            requestToSignup(
                password: password,
                data: nil
            )
        }
    }
}
