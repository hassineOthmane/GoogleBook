//
//  BooksListView.swift
//  googleBook
//
//  Created by hassine othmane on 7/10/21.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewBooksListProtocol:BaseViewProtocol {

    var presenter: ViewToPresenterBooksListProtocol? { get set }

    func showBooks()

}

class BooksListView: UIViewController {

    private let ui = BooksListViewUI()

    var presenter: ViewToPresenterBooksListProtocol?

    public override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        presenter?.fetchBooks()

    }

    func initUI() -> Void {
        ui.delegate = self
        ui.dataSource = self
        view = ui
    }

}

// MARK: - extending BooksListView to implement the custom ui view data source
extension BooksListView: BooksListViewUIDataSource {
    func isOffline() -> Bool {
        presenter?.isOffline ?? false
    }


    func getBooksCount() -> Int {
        return presenter?.getBooksCount() ?? 0
    }

    func getBooks() -> [BookModel] {
        return  presenter?.getBooks() ?? [BookModel]()
    }

}

// MARK: - BooksListViewUIDelegate
extension BooksListView : BooksListViewUIDelegate
{
    func showPDF(book: BookModel) {
        presenter?.showPDF(book: book)
    }

    func saveFavoris(book: BookModel) {
        presenter?.saveFavoris(book: book)
    }

    func fetchMoreBooks(page: Int) {
        presenter?.fetchMoreBooks(index: page)
    }
}


// MARK: BooksListViewUI Delegate -
protocol BooksListViewUIDelegate {

    func fetchMoreBooks(page:Int)
    func saveFavoris(book:BookModel)
    func showPDF(book: BookModel)
}

// MARK: BooksListViewUI DataSource -
protocol BooksListViewUIDataSource {

    func getBooks() -> [BookModel]

    func getBooksCount() -> Int

    func isOffline() -> Bool
}

extension BooksListView: PresenterToViewBooksListProtocol {
    func showBooks() {
        ui.isLoading = false
        DispatchQueue.main.async { [self] in
            ui.tableView.reloadData()
        }
    }

    var viewController: UIViewController {
        return self
    }
}
