import Foundation
import BaseFeature
import Alamofire
import AuthDomain

class FindIdViewModel: BaseViewModel {
    func requestToFindId(
        phoneNumber: String,
        completion: @escaping (Result<FindIdModelDecodable, Error>) -> Void = { _ in }) {
        print("PhoneNumber!E!#!@# = \(phoneNumber)")
        AF.request(FindIdTarget.findId(
            FindIdModelEncodable(
                phoneNumber: phoneNumber
            )
        ))
        .validate()
        .responseDecodable(of: FindIdModelDecodable.self) { response in
            print("url = \(response.response?.url)")
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print("Error - findId = \(error.localizedDescription)")
            }
        }
    }
}
