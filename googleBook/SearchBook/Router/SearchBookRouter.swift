//
//  SearchBookRouter.swift
//  googleBook
//
//  Created by hassine othmane on 7/10/21.
//

import UIKit

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSearchBooksProtocol {

    func createModule() -> UIViewController

    func showBooks(for viewController : UIViewController,title:String,author:String)
}

public class SearchBooksRouter: PresenterToRouterSearchBooksProtocol {

    public init() {}

    public func createModule() -> UIViewController {
        let vc = SearchBooksView.init()
        let presenter: ViewToPresenterSearchBooksProtocol = SearchBooksPresenter.init()
        let router : PresenterToRouterSearchBooksProtocol = SearchBooksRouter.init()
        vc.presenter = presenter
        vc.presenter?.router = router
        vc.presenter?.view = vc
        return vc
    }

    func showBooks(for viewController: UIViewController,title:String,author:String) {
        let vc = BooksListRouter.init().createModule(title: title, author: author)
        viewController.show(vc, sender: nil)
    }

}
