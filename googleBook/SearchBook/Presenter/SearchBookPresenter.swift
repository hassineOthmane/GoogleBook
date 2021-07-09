//
//  SearchBookPresenter.swift
//  googleBook
//
//  Created by hassine othmane on 7/10/21.
//

import Foundation

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSearchBooksProtocol {

    var view: PresenterToViewSearchBooksProtocol? { get set }

    var router: PresenterToRouterSearchBooksProtocol? { get set }

    /// functions
    func showBooks(title:String,author:String)


}


class SearchBooksPresenter: ViewToPresenterSearchBooksProtocol {

    var view: PresenterToViewSearchBooksProtocol?

    var router: PresenterToRouterSearchBooksProtocol?

    func showBooks(title:String,author:String) {
        
        if let viewController = view?.viewController
        {
            router?.showBooks(for: viewController,title:title,author:author)
        }

    }


}
