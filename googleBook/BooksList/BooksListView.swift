//
//  BooksListView.swift
//  googleBook
//
//  Created by hassine othmane on 7/10/21.
//

import UIKit

class BooksListView: UIViewController {

    private let ui = BooksListViewUI()

    var books = [BookModel]()

    var titleBook: String!
    var author: String!

    public override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        self.fetchBooks(title: titleBook, author: author) {(result: Result<BooksModel, Error>) in
            switch result {
            case .success(let books):
                self.books = books.items
                self.ui.reloadData()
                break;
            case .failure(let error):
                print(error)
                break;
            }
        }

    }

    func initUI() -> Void {
        ui.delegate = self
        ui.dataSource = self
        view = ui
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

// MARK: - extending NewsListView to implement the custom ui view data source
extension BooksListView: BooksListViewUIDataSource {

    func getBooksCount() -> Int {
        return books.count
    }

    func getBooks() -> [BookModel] {
        return  books
    }

}

// MARK: - NewsListViewUIDelegate
extension BooksListView : BooksListViewUIDelegate
{
    func fetchMoreBooks(page: Int) {
        self.fetchMoreBooks(title: titleBook, author: author, index: page) {(result: Result<BooksModel, Error>) in
            switch result {
            case .success(let books):
                self.books.append(contentsOf: books.items)
                self.ui.reloadData()
                self.ui.isLoading = false
                break;
            case .failure(let error):
                print(error)
                break;
            }
        }
    }


}


// MARK: BooksListViewUI Delegate -
protocol BooksListViewUIDelegate {

    func fetchMoreBooks(page:Int)
}

// MARK: BooksListViewUI DataSource -
protocol BooksListViewUIDataSource {

    func getBooks() -> [BookModel]

    func getBooksCount() -> Int
}
