//
//  NetworkRouter.swift
//  googleBook
//
//  Created by hassine othmane on 7/9/21.
//

import Foundation

public protocol NetworkRouter {

    var scheme: String { get }

    var host: String { get }

    var path: String { get }

    var method: NetworkMethod { get }

    var queries: [URLQueryItem] { get }

    var url: URL? { get }
}

