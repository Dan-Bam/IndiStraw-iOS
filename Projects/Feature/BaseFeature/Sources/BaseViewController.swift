import UIKit
import SnapKit
import Then
import DesignSystem

open class BaseVC<T: BaseViewModel>: UIViewController {
    let bound = UIScreen.main.bounds
    
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
}
