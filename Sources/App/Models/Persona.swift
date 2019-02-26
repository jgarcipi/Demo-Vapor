//
//  Person.swift
//  App
//
//  Created by Everis on 26/02/19.
//

import Foundation
import Vapor

struct Person: Content {
    let firstName: String
    let lastName: String?
}
