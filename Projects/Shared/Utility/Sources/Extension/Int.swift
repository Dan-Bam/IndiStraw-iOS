import Foundation

public extension Int {
    func setMoneyType() -> String {
        let numberFormatter = NumberFormatter()
        let value = NSNumber(value: self)
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: value)!
    }
}
