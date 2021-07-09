//
//  BooksListView.swift
//  googleBook
//
//  Created by hassine othmane on 7/10/21.
//

import UIKit

class BooksListView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.fetchBooks {(result: Result<BooksModel, Error>) in
            switch result {
            case .success(let books):
                print(books)
                //self.presenter?.setNews(news: news)
                break;
            case .failure(let error):
                print(error)
                break;
            }
        }

        // Do any additional setup after loading the view.
    }

    func fetchBooks(completion: @escaping (Result<BooksModel, Error>) -> Void) {
        let titleQueryItem = URLQueryItem(name: "q", value: "assommoir")
        let authorQueryItem = URLQueryItem(name: "inauthor", value: "zola")
        let networkRequest:NetworkRouter = HTTPRouter.init(method: .get, scheme: "https", host: "www.googleapis.com", path: "/books/v1", endPoint: HTTPEndPoint.getBooks, queries: [titleQueryItem,authorQueryItem])
        let testNetworkLayer = HTTPLayer.init()
        let service = BookNetworkService.init(networkLayer: testNetworkLayer, networkRouter:networkRequest )
        service.fetchBooks(completion: completion)
   }


}
