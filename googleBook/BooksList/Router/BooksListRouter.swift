//
//  BooksListRouter.swift
//  googleBook
//
//  Created by hassine othmane on 7/10/21.
//

import UIKit



// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterBooksListProtocol {

    func createModule(title:String,author:String) -> UIViewController
    func createModule(isOffline:Bool) -> UIViewController
    func showPDF(for viewController: UIViewController,book:BookModel)
    
}

public class BooksListRouter: PresenterToRouterBooksListProtocol {

    public init() {}

    public func createModule(title:String,author:String) -> UIViewController {
        let vc = BooksListView.init()
        let presenter: ViewToPresenterBooksListProtocol & InteractorToPresenterBooksListProtocol = BooksListPresenter.init()
        let router : PresenterToRouterBooksListProtocol = BooksListRouter.init()
        vc.presenter = presenter
        vc.presenter?.router = router
        vc.presenter?.title = title
        vc.presenter?.author = author
        vc.presenter?.view = vc
        vc.presenter?.interactor = BooksListInteractor()
        vc.presenter?.interactor?.presenter = presenter
        return vc
    }

    public func createModule(isOffline:Bool) -> UIViewController {
        let vc = BooksListView.init()
        let presenter: ViewToPresenterBooksListProtocol & InteractorToPresenterBooksListProtocol = BooksListPresenter.init()
        let router : PresenterToRouterBooksListProtocol = BooksListRouter.init()
        vc.presenter = presenter
        vc.presenter?.router = router
        vc.presenter?.isOffline = isOffline
        vc.presenter?.view = vc
        vc.presenter?.interactor = BooksListInteractor()
        vc.presenter?.interactor?.presenter = presenter
        return vc
    }

    public func showPDF(for viewController: UIViewController,book:BookModel)
    {
        let vc = BookDetailView()
        let presenter : ViewToPresenterBookDetailProtocol = BookDetailPresenter.init(book: book)
        vc.presenter = presenter
        viewController.show(vc, sender: nil)

    }

}
