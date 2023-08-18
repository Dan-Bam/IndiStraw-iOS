import Foundation
import BaseFeature
import Alamofire

public class FindIdViewModel: BaseViewModel {
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
    
    func popToRootVC() {
        coordinator.navigate(to: .popToRootIsRequired)
    }
}
