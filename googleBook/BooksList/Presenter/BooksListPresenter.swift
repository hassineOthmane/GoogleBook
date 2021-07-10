//
//  BooksListPresenter.swift
//  googleBook
//
//  Created by hassine othmane on 7/10/21.
//

import Foundation

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterBooksListProtocol {

    var view: PresenterToViewBooksListProtocol? { get set }

    var router: PresenterToRouterBooksListProtocol? { get set }

    var title: String? { get set }

    var author: String? { get set }

    var books : [BookModel]? {get set }

    func fetchBooks()

    func fetchMoreBooks(index:Int)

    func getBooksCount() -> Int

    func getBooks() -> [BookModel]


}


class BooksListPresenter: ViewToPresenterBooksListProtocol {

    var view: PresenterToViewBooksListProtocol?

    var router: PresenterToRouterBooksListProtocol?

    var books: [BookModel]? = [BookModel]()

    var title: String?
    
    var author: String?

    func fetchBooks() {
        if let title = title, let author = author
        {
            self.fetchBooks(title: title, author: author) {(result: Result<BooksModel, Error>) in
                switch result {
                case .success(let books):
                    self.books = books.items
                    self.view?.showBooks()
                    break;
                case .failure(let error):
                    print(error)
                    break;
                }
            }
        }

    }

    func fetchMoreBooks( index: Int) {
        if let title = title, let author = author
        {
            self.fetchMoreBooks(title: title, author: author, index: index) {(result: Result<BooksModel, Error>) in
                switch result {
                case .success(let books):
                    self.books?.append(contentsOf: books.items)
                    self.view?.showBooks()
                    break;
                case .failure(let error):
                    print(error)
                    break;
                }
            }
        }
    }

    func getBooksCount() -> Int {
        books?.count ?? 0
    }

    func getBooks() -> [BookModel] {
        books ?? [BookModel]()
    }

    func fetchBooks(title:String,author:String,completion: @escaping (Result<BooksModel, Error>) -> Void) {
        let titleQueryItem = URLQueryItem(name: "q", value: title)
        let authorQueryItem = URLQueryItem(name: "inauthor", value: author)
        let networkRequest:NetworkRouter = HTTPRouter.init(method: .get, scheme: "https", host: "www.googleapis.com", path: "/books/v1", endPoint: HTTPEndPoint.getBooks, queries: [titleQueryItem,authorQueryItem])
        let testNetworkLayer = HTTPLayer.init()
        let service = BookNetworkService.init(networkLayer: testNetworkLayer, networkRouter:networkRequest )
        service.fetchBooks(completion: completion)
    }

    func fetchMoreBooks(title:String,author:String,index:Int,completion: @escaping (Result<BooksModel, Error>) -> Void) {
        let titleQueryItem = URLQueryItem(name: "q", value: title)
        let authorQueryItem = URLQueryItem(name: "inauthor", value: author)
        let indexQueryItem = URLQueryItem(name: "startIndex", value: index.description)
        let networkRequest:NetworkRouter = HTTPRouter.init(method: .get, scheme: "https", host: "www.googleapis.com", path: "/books/v1", endPoint: HTTPEndPoint.getBooks, queries: [titleQueryItem,authorQueryItem,indexQueryItem])
        let testNetworkLayer = HTTPLayer.init()
        let service = BookNetworkService.init(networkLayer: testNetworkLayer, networkRouter:networkRequest )
        service.fetchBooks(completion: completion)
    }

}
