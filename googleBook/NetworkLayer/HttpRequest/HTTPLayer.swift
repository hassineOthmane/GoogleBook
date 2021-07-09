//
//  HTTPLayer.swift
//  googleBook
//
//  Created by hassine othmane on 7/9/21.
//

import Foundation


public class HTTPLayer: NetworkLayer {

    public init() {

    }

    public func sendRequest<T>(_ router: NetworkRouter, completion: @escaping NetworkResponseCompletion<T>) where T : Decodable {

        guard let httpRequest = router as? HTTPRouter else {
            completion(.failure(HTTPError.badRequest))
            return
        }

        var components = URLComponents()
        components.scheme = httpRequest.scheme
        components.host = httpRequest.host
        components.path = httpRequest.path+httpRequest.endPoint.description

        components.queryItems = httpRequest.queries

        guard let url = components.url else {
            completion(.failure(HTTPError.badRequest))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method.rawValue

        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in

            if let err = error {
                completion(.failure(err))
                return
            }
            guard response != nil, let data = data else {
                completion(.failure(HTTPError.noResponseData))
                return
            }

            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            do {
                let decodedObject = try jsonDecoder.decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(HTTPError.decodingError))
            }
        }
        dataTask.resume()
    }
}

