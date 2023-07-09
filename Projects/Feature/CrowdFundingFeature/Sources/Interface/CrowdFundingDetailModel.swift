import Foundation

struct CrowdFundingDetailResponse: Decodable {
    var title: String
    var description: String
    var writer: Writer
    var amount: Amount
    var remainingDay: Int
    var fundingCount: Int
    var reward: [Reward]
    var status: String
    var thumbnailUrl: String
    var imageList: [String]
    var fileList: [String]
}

struct Writer: Decodable {
    var idx = UUID().uuidString
    var name: String
}

struct Amount: Decodable {
    var targetAmount: Int
    var totalAmount: Int
    var percentage: Int
}

struct Reward: Decodable {
    var title: String
    var description: String
    var price: Int
    var imageUrl: String
}
