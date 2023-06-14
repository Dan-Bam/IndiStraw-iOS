import UIKit
import DesignSystem
import RxSwift
import RxCocoa

open class BaseVC<T: BaseViewModel>: UIViewController {
    let bound = UIScreen.main.bounds
    
    let disposeBag = DisposeBag()
    
    public let viewModel: T
    
    public init(viewModel: T){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @available(*, unavailable)
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let backBarButtonItem = UIBarButtonItem(title: "뒤로가기", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: DesignSystemFontFamily.Suit.bold.font(size: 24)]
        setKeyboard()
        setup()
        addView()
        setLayout()
        configureVC()
    }
    
    @available(*, unavailable)
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.coordinator.didFinish(coordinator: viewModel.coordinator)
    }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }

    open func setup(){}
    open func addView(){}
    open func setLayout(){}
    open func configureVC(){}
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setKeyboard() {
        let keyboardWillShow = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
        let keyboardWillHide =
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
        
        keyboardWillShow
            .asDriver(onErrorRecover: { _ in .never()})
            .drive(with: self) { owner, noti in
                owner.keyboardUp(noti)
            }.disposed(by: disposeBag)
        
        keyboardWillHide
            .asDriver(onErrorRecover: { _ in .never()})
            .drive(with: self) { owner, noti in
                owner.keyboardDown()
            }.disposed(by: disposeBag)
    }
    
    private func keyboardUp(_ notification: Notification) {
        if let keyboardFrame:CGRect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame.origin.y -= keyboardFrame.size.height
                }
            )
        }
    }
    
    private func keyboardDown() {
        self.view.frame.origin.y = .zero
    }
}
