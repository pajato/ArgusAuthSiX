//
//  ArgusAuth.swift
//  ArgusAuth
//
//  Created by Paul Reilly on 7/29/18.
//  Copyright © 2018 pajato. All rights reserved.
//

import Foundation
import ValidationComponents

func validate(_ credentials: Credentials) -> AuthResult {
    let predicate = EmailPredicate()

    func validateEmail(using email: String) -> [ErrorType:String] {
        let errorMessage = "Email addresses must be of the form 'name@domain.extension'"
        return predicate.evaluate(with: credentials.email) ? [:] : [.InvalidEmail : errorMessage]
    }

    func validatePassword(using password: String) -> [ErrorType:String] {
        let errorMessage = "Passwords must have more than eight characters."
        return credentials.password.count < 8 ? [.InvalidPassword : errorMessage] : [:]
    }

    var errors = validateEmail(using: credentials.email)
    errors.update(other: validatePassword(using: credentials.password))
    return errors.count == 0 ? AuthResult(withToken: "someToken", withErrors: errors) : AuthResult(withToken: "", withErrors: errors)
}

enum ErrorType {
    case InvalidPassword
    case InvalidEmail
}

class AuthResult {
    let token: String
    let errors: [ErrorType:String]

    init(withToken token: String,
         withErrors errors: [ErrorType:String]) {
        self.token = token
        self.errors = errors
    }
}

class Credentials {
    let email: String
    let password: String

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
