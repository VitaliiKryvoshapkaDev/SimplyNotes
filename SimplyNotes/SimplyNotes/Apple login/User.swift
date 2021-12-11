//
//  User.swift
//  SimplyNotes
//
//  Created by Vitalii Kryvoshapka on 10.12.2021.
//

import Foundation


struct User{
    let id: String
    let firstName: String
    let lastName: String
    let email: String
}

extension User: CustomDebugStringConvertible{
    var debugDescription: String{
        return """
ID: \(id)
FirstName: \(firstName)
LastName: \(lastName)
Email: \(email)
"""
    }
}
