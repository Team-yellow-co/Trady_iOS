//
//  LoginForm.swift
//  Trady
//
//  Created by bumslap on 2021/01/29.
//

import Foundation

struct LoginForm {
    
    init(type: LoginType, email: String? = nil, password: String? = nil) {
        self.type = type
        self.email = email
        self.password = password
    }
    
    let type: LoginType
    let email: String?
    let password: String?
    
    
}
