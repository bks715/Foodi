//
//  ActionableError.swift
//  Foodi
//
//  Created by Braden Smith on 3/5/24.
//

import Foundation

///A struct that represents an error that can be acted upon by the user.
///This is useful for presenting an alert to the user with a message and an action to take.
public struct ActionableError {
    
    var title: String
    var message: String?
    var action: (() -> Void)?
    
    ///Initialize an ActionableError
    ///- Parameters:
    ///- title: The title of the error
    ///- message: The message of the error
    ///- action: The action to take when the user interacts with the error
    init(_ title: String, message: String? = nil, action: (() -> Void)? = nil){
        self.title = title
        self.message = message
        self.action = action
    }
    
}
