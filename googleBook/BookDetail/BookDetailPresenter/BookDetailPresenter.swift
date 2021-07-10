//
//  BookDetailPresenter.swift
//  googleBook
//
//  Created by hassine othmane on 7/10/21.
//

import Foundation

protocol ViewToPresenterBookDetailProtocol {


    var view: PresenterToViewBookDetailProtocol? { get set }

    func getBook() -> BookModel?

}

class BookDetailPresenter: ViewToPresenterBookDetailProtocol {

    var view: PresenterToViewBookDetailProtocol?

    var book : BookModel?

    init(book : BookModel?) {
        self.book = book
    }

    func getBook() -> BookModel? {
        return book
    }

}
