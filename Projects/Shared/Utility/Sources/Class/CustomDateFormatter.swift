import UIKit

public protocol CustomDateFormatterProtocol: AnyObject {
    static var shared: CustomDateFormatterProtocol { get }
    
    func getStringToDate(from string: String) -> Date?
}

public class CustomDateFormatter: CustomDateFormatterProtocol {
    public static var shared: CustomDateFormatterProtocol = CustomDateFormatter()
    
    private init() {}
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }()
    
    public func getStringToDate(from string: String) -> Date? {
        return formatter.date(from: string)
    }
}
