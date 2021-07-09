//
//  NetworkLayer.swift
//  googleBook
//
//  Created by hassine othmane on 7/9/21.
//

import Foundation

public typealias NetworkResponseCompletion<T: Decodable> = (Result<T, Error>) -> Void

public protocol NetworkLayer {

    func sendRequest<T: Decodable>(_ request: NetworkRouter, completion: @escaping NetworkResponseCompletion<T>)

}
