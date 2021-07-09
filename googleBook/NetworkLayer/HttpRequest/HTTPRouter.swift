//
//  HTTPRouter.swift
//  googleBook
//
//  Created by hassine othmane on 7/9/21.
//

import Foundation

public struct HTTPRouter: NetworkRouter {

    public var method: NetworkMethod

    public var scheme: String

    public var host: String

    public var path: String

    public var endPoint: HTTPEndPoint

    public var queries: [URLQueryItem]

    public var url: URL? {

        return URL.init(string: scheme+host+path)!

    }

    public init(method:NetworkMethod,scheme:String,host:String,path:String,endPoint:HTTPEndPoint,queries: [URLQueryItem]) {
        self.method = method
        self.scheme = scheme
        self.host = host
        self.path = path
        self.endPoint = endPoint
        self.queries = queries
    }

}

