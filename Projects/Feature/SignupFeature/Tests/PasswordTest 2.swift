//
//  PasswordTest.swift
//  SignupFeatureTests
//
//  Created by 민도현 on 2023/06/12.
//  Copyright © 2023 dohyeon. All rights reserved.
//

import XCTest

final class PasswordTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPassword_inputPassword_returnTrue() {
            let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]+$"
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
            print(passwordTest.evaluate(with: "Asdf1234@"))
                  
            XCTAssertTrue((passwordTest.evaluate(with: "Asdf1234@")))
    }

}
