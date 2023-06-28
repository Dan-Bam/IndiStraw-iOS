//Endocable
struct CrowdFundingRequest: Encodable {
    var page: String
    var size: String
}

//Decodable
struct CrowdFundingResponse: Decodable {
    var pageSize: Int
    var isLast: Bool
    var list: [FundingList]
}

struct FundingList: Decodable {
    var idx: Int
    var title: String
    var description: String
    var percentage: Int
    var thumbnailUrl: String
    var activity: String
}
