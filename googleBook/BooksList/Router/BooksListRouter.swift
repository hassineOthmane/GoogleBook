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
    
}

public class BooksListRouter: PresenterToRouterBooksListProtocol {

    public init() {}

    public func createModule(title:String,author:String) -> UIViewController {
        let vc = BooksListView.init()
        let presenter: ViewToPresenterBooksListProtocol = BooksListPresenter.init()
        let router : PresenterToRouterBooksListProtocol = BooksListRouter.init()
        vc.presenter = presenter
        vc.presenter?.router = router
        vc.presenter?.title = title
        vc.presenter?.author = author
        vc.presenter?.view = vc
        return vc
    }
}
