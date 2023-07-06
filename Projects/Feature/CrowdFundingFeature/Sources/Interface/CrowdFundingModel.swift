//Endocable
struct CrowdFundingListRequest: Encodable {
    var page: Int
    var size: Int = 10
}

struct CrowdFundingListResopnse: Decodable {
    var isLast: Bool
    var list: [FundingDataList]
}

struct FundingDataList: Decodable {
    var idx: Int
    var title: String
    var description: String
    var percentage: Int
    var thumbnailUrl: String
    var status: String
}
