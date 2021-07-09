//
//  HTTPEndPoint.swift
//  googleBook
//
//  Created by hassine othmane on 7/9/21.
//

import Foundation

public enum HTTPEndPoint {

    case getBooks

    var description: String {

        switch self {

        case .getBooks: return "/volumes"

        }
    }

}
