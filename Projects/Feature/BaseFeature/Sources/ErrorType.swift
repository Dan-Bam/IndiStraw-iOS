public enum PhoneNumberErrorType: Error {
    case cantSendAuthNumber
    case tooManyRequestException
}

public enum CheckPhoneDuplicateErrorType: Error {
    case cantFindPhoneNumber
    case duplicatePhoneNumber
}
