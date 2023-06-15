import Foundation
import BaseFeature
import Alamofire
import AuthDomain

class FindIdViewModel: BaseViewModel {
    var phoneNumber: String
    
    init(coordinator: Coordinator, phoneNumber: String) {
        self.phoneNumber = phoneNumber
        super.init(coordinator: coordinator)
    }
    
    func requestToFindId(
        phoneNumber: String,
        completion: @escaping (Result<FindIdModelDecodable, Error>) -> Void = { _ in }) {
        AF.request(FindIdTarget.findId(
            FindIdModelEncodable(
                phoneNumber: phoneNumber
            )
        ))
        .validate()
        .responseDecodable(of: FindIdModelDecodable.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print("Error - findId = \(error.localizedDescription)")
            }
        }
    }
}
