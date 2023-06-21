struct AddressModel: Encodable {
    var confmKey: String
    var currentPage: Int
    var countPerPage: Int = 10
    var keyword: String
    var resultType: String = "json"
}
