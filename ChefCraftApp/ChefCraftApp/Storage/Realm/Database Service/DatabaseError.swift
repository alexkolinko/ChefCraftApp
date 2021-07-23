//
//  DatabaseError.swift
//  ChefCraftApp
//
//  Created by Work on 22.07.2021.
//

import Foundation

enum DatabaseError: Error {
    case unexpectedError
    case saveFailed(String)
    case deleteFailed(String)
    case objectNotExists
}
