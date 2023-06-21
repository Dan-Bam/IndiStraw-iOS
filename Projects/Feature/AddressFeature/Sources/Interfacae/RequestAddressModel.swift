struct RequestAddressModel: Encodable {
    var confmKey: String = "U01TX0FVVEgyMDIzMDYxODEzNDkzODExMzg1ODU="
    var currentPage: Int
    var countPerPage: Int = 10
    var keyword: String
    var resultType: String = "json"
}

struct ResponseAddressModel: Decodable {
    var results: Results
}

struct Results: Decodable {
    var juso: [Juso]
}

struct Juso: Decodable {
    var roadAddrPart1: String
    var bdNm: String
}
