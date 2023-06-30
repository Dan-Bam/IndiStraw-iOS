//Endocable
struct CrowdFundingRequest: Encodable {
    var page: Int
    var size: Int = 10
}

//Decodable
struct CrowdFundingResponse: Decodable {
    var isLast: Bool
    var list: [FundingList]
}

struct FundingList: Decodable {
    var idx: Int
    var title: String
    var description: String
    var percentage: Int
    var thumbnailUrl: String
    var status: String
}
