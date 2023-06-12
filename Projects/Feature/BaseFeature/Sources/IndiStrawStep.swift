import UIKit

public enum IndiStrawStep {
    case signinIsRequired
    case signupIsRequired
    
    //signup
    case selectPhotoIsRequired(name: String, phoneNumber: String)
    case inputNameIsRequired
    case inputPhoneNumberIsRequired(name: String)
    case inputIDIsRequired(image: UIImage?, name: String, phoneNumber: String)
    case inputPasswordIsRequired(id: String, name: String, phoneNumber: String)
    
    //pop
    case popToRootIsRequired
}
