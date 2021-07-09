//
//  HTTPError.swift
//  googleBook
//
//  Created by hassine othmane on 7/9/21.
//

import Foundation

public enum HTTPError: LocalizedError {

    case badRequest

    case unauthorized

    case notFound

    case internalServerError

    case decodingError

    case noResponseData

    case unknown(Error)

}
