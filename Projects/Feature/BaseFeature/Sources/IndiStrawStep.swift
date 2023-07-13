import UIKit

public enum IndiStrawStep {
    
    //root
    case signinIsRequired
    case signupIsRequired
    
    //signin
    case phoneNumberAuthIsRequired(type: InputPhoneNumberType)
    case setHomeIsRequired
    
    //findPassword
    case changePasswordIsRequired(phoneNumber: String)
    
    //findId
    case findIdIsRequired(phoneNumber: String)
    
    //signup
    case selectPhotoIsRequired(name: String, phoneNumber: String)
    case inputNameIsRequired
    case inputPhoneNumberIsRequired(name: String)
    case inputIDIsRequired(image: UIImage?, name: String, phoneNumber: String)
    case inputPasswordIsRequired(id: String, name: String, phoneNumber: String, profileImage: UIImage?)
    
    //pop
    case popToRootIsRequired
    case popViewIsRequired
    
    //home
    case movieDetailIsRequired(idx: Int)
    case createMovieVCIsReuiqred
    case crowdFundingDetailIsRequired(idx: Int)
    case crowdFundingListIsRequired
    case crowdFunding
    case profileIsRequired
    
    //profile
    case settingIsRequired
    
    //setting
    case editProfileIsRequired
    
    //editProfile
    case changePhoneNumberIsRequired
    case findAddressIsRequired
    
    //address
    case detailAddressisRequired(zipCode: String, roadAddrPart: String)
}
