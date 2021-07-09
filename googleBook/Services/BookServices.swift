//
//  BookServices.swift
//  googleBook
//
//  Created by hassine othmane on 7/9/21.
//

protocol BooksNetworkServiceProtocol {

    func fetchBooks(completion: @escaping (Result<BooksModel, Error>) -> Void)

}

public struct BookNetworkService: BooksNetworkServiceProtocol {

    private let networkLayer: NetworkLayer

    private let networkRouter :NetworkRouter

    public init(networkLayer: NetworkLayer,networkRouter :NetworkRouter)
    {
        self.networkLayer = networkLayer
        self.networkRouter = networkRouter
    }

    public func fetchBooks(completion: @escaping (Result<BooksModel, Error>) -> Void) {
        let httpRouter = HTTPRouter.init(method: .get, scheme: networkRouter.scheme, host: networkRouter.host, path: networkRouter.path, endPoint: .getBooks, queries: networkRouter.queries)
        networkLayer.sendRequest(httpRouter, completion: completion)

    }

}
