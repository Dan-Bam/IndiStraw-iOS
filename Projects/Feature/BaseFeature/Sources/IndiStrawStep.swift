import UIKit

public enum IndiStrawStep {
    
    //root
    case signinIsRequired
    case signupIsRequired
    
    //signin
    case findPasswordIsRequired
    case findIdIsRequired
    
    //signup
    case selectPhotoIsRequired(name: String, phoneNumber: String)
    case inputNameIsRequired
    case inputPhoneNumberIsRequired(name: String)
    case inputIDIsRequired(image: UIImage?, name: String, phoneNumber: String)
    case inputPasswordIsRequired(id: String, name: String, phoneNumber: String, profileImage: UIImage?)
    
    //pop
    case popToRootIsRequired
}
