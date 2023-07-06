import Foundation
import BaseFeature
import RxSwift
import RxCocoa
import Alamofire
import JwtStore

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class AddressViewModel: BaseViewModel, ViewModelType {
    var disposeBag = DisposeBag()
    
    var addressData = BehaviorRelay<[Juso]>(value: [])
    
    var currentPage = 0
    
    func transform(input: Input) -> Output {
        input.inputKeyword.bind(with: self) { owner, arg in
            owner.requestAddress(keyword: arg)
        }.disposed(by: disposeBag)
        
        return Output(outAddressData: addressData)
    }
    
    struct Input {
        var inputKeyword: Observable<String>
    }
    
    struct Output {
        var outAddressData: BehaviorRelay<[Juso]>
    }
    
    func requestAddress(keyword: String) {
        AF.request(AddressTarget.searchAddress(
            RequestAddressModel(
                currentPage: currentPage,
                keyword: keyword
            )
        ))
        .validate()
        .responseDecodable(of: ResponseAddressModel.self) { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.addressData.accept(data.results.juso)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func pushDetailAddressVC(data: Juso) {
        coordinator.navigate(to: .detailAddressisRequired(zipCode: data.zipNo, roadAddrPart: data.roadAddrPart1))
    }
}
