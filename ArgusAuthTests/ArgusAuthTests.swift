
import XCTest

@testable import ArgusAuth

class ArgusAuthTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWithEmptyCredentials_generateTwoErrors() {
        let credentials = Credentials(email: "", password: "")
        let result = validate(credentials)
        XCTAssertEqual(2, result.errors.count)
        XCTAssertEqual("", result.token)
    }

    func testWithInvalidEmailAndValidPassword_generateEmaiError() {
        let credentials = Credentials(email: "hello@", password: "12345678")
        let result = validate(credentials)
        XCTAssertEqual(1, result.errors.count)
        XCTAssertEqual("", result.token)
    }

    func testWithInvalidPasswordAndValidEmail_generatePasswordError() {
        let credentials = Credentials(email: "hello@gmail.com", password: "1234567")
        let result = validate(credentials)
        XCTAssertEqual(1, result.errors.count)
        XCTAssertEqual("", result.token)
    }

    func testWithValidPasswordAndValidEmail_generateToken() {
        let credentials = Credentials(email: "hello@gmail.com", password: "12345678")
        let result = validate(credentials)
        XCTAssertEqual(0, result.errors.count)
        XCTAssert(result.token.count > 0)
    }

}
