//
//  BookDetailRouter.swift
//  googleBook
//
//  Created by hassine othmane on 7/10/21.
//

import UIKit

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterBookDetailProtocol {

    func createModule(book:BookModel) -> UIViewController

}

public class BookDetailRouter: PresenterToRouterBookDetailProtocol {

    func createModule(book: BookModel) -> UIViewController {
        let vc = BookDetailView()
        let presenter : ViewToPresenterBookDetailProtocol = BookDetailPresenter.init(book: book)
        vc.presenter = presenter
        return vc
    }
}
