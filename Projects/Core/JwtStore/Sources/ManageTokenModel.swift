import Foundation

public struct ManageTokenModel: Codable {
    public var accessToken: String
    public var refreshToken: String
    public var accessTokenExpiredAt: String
    public var refreshTokenExpiredAt: String
}
