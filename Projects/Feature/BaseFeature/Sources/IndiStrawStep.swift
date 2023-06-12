public enum IndiStrawStep {
    case signinIsRequired
    case signupIsRequired
    
    //signup
    case selectPhotoIsRequired(name: String, phoneNumber: String)
    case inputNameIsRequired
    case inputPhoneNumberIsRequired(name: String)
    case inputIDIsRequired
    case inputPasswordIsRequired
    
    //pop
    case popToRootIsRequired
}
