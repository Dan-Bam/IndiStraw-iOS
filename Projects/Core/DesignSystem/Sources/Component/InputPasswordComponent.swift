import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

public protocol InputPasswordComponentProtocol: AnyObject {
    func isValidPassword(password: String)
    func confirmButtonDidTap(password: String)
}

public class InputPasswordComponent: UIView {
    public weak var delegate: InputPasswordComponentProtocol?
    
    public var isValidPassword = false

    private let disposeBag = DisposeBag()
    
    public let inputPasswordTextField = TextFieldBoxComponent().then {
        $0.setPlaceholer(text: "비밀번호")
    }
    
    public let inputCheckPasswordTextField = TextFieldBoxComponent().then {
        $0.setPlaceholer(text: "비밀번호 확인")
    }
    
    public let confirmButton = ButtonComponent().then {
        $0.setTitle("확인하기", for: .normal)
    }
    
    private let errorLabel = ErrorLabelComponent()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addView()
        setLayout()
        
        confirmButton.rx.tap
            .bind(with: self) { owner, _ in
                let password = owner.inputPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let checkPassword = owner.inputCheckPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                owner.showEmptyPasswordError(password: password, checkPassword: checkPassword)
                
                if owner.isValidPassword {
                    owner.delegate?.confirmButtonDidTap(password: password)
                }
            }.disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        self.addSubviews(inputPasswordTextField, inputCheckPasswordTextField,
                         confirmButton, errorLabel)
    }
    
    func setLayout() {
        inputPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(140)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        inputCheckPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(inputPasswordTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(inputCheckPasswordTextField.snp.bottom).offset(7)
            $0.leading.equalTo(inputCheckPasswordTextField.snp.leading)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(inputCheckPasswordTextField.snp.bottom).offset(37)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(54)
        }
    }
    
    func showEmptyPasswordError(password: String, checkPassword: String) {
        if password.isEmpty {
            errorLabel.text = "비밀번호를 입력해주세요."
            isValidPassword = false
        } else if checkPassword.isEmpty {
            errorLabel.text = "비밀번호 확인을 입력해주세요."
            isValidPassword = false
        } else {
            isValidPassword(password: password, checkPassword: checkPassword)
        }
    }
    
    func isValidPassword(password: String, checkPassword: String) {
        guard (8...20).contains(password.count) else {
            errorLabel.text = "8~20자 사이로 입력해주세요."
            isValidPassword = false
            return
        }
        
        delegate?.isValidPassword(password: password)
        
        isPasswordMatch(password: password, checkPassword: checkPassword)
    }
    
    func isPasswordMatch(password: String, checkPassword: String) {
        if password != checkPassword {
            errorLabel.text = "비밀번호가 일치하지 않습니다."
            isValidPassword = false
            return
        }
        
        isValidPassword = true
    }
    
    public func changeErrorText(text: String) {
        errorLabel.text = text
    }
}
