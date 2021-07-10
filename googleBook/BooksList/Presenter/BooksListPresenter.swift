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

    var interactor: PresenterToInteractorBooksListProtocol? { get set }

    var router: PresenterToRouterBooksListProtocol? { get set }

    var title: String? { get set }

    var author: String? { get set }

    var isOffline: Bool { get set }

    var books : [BookModel]? {get set }

    func fetchBooks()

    func fetchMoreBooks(index:Int)

    func getBooksCount() -> Int

    func getBooks() -> [BookModel]

    func saveFavoris(book: BookModel)

    func removeFavoris(book: BookModel)

    func showDetail(book: BookModel)

}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterBooksListProtocol {

    func set(books:BooksModel)

    func loadMore(books:BooksModel)

}

// MARK: BooksListPresenter
class BooksListPresenter: ViewToPresenterBooksListProtocol {

    var isOffline: Bool = false

    var view: PresenterToViewBooksListProtocol?

    var interactor: PresenterToInteractorBooksListProtocol?

    var router: PresenterToRouterBooksListProtocol?

    var books: [BookModel]? = [BookModel]()

    var title: String?
    
    var author: String?
    
    func fetchBooks() {

        if !isOffline{
            if let title = title, let author = author {
                interactor?.fetchBooks(title: title, author: author)
            }
        } else
        {
            interactor?.fetchFavoritesBook()
        }

    }

    func fetchMoreBooks( index: Int) {
        if !isOffline{
        if let title = title, let author = author {
            interactor?.fetchMoreBooks(title: title, author: author, index: index)
        }}
    }

    func getBooksCount() -> Int {
        books?.count ?? 0
    }

    func getBooks() -> [BookModel] {
        books ?? [BookModel]()
    }

    func removeFavoris(book: BookModel) {
        interactor?.removeFavoris(book: book)
    }

    func showDetail(book: BookModel) {
        if let viewController = self.view?.viewController
        {
            router?.showBookDetail(for:viewController, book: book)
        }
    }

    func saveFavoris(book: BookModel) {
        interactor?.saveFavoris(book: book)
    }

}


extension BooksListPresenter: InteractorToPresenterBooksListProtocol
{
    func loadMore(books: BooksModel) {
        self.books?.append(contentsOf: books.items)
        view?.showBooks()
    }

    func set(books: BooksModel) {
       self.books = books.items
        view?.showBooks()
    }

}
