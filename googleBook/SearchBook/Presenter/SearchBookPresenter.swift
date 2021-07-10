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

    func showBooks(title:String,author:String)

    func viewDidLoad() -> Void

    func showLibrary()

    func saveLastSearchValue(title:String,author:String)

}

// MARK: View SearchBooksPresenter
class SearchBooksPresenter: ViewToPresenterSearchBooksProtocol {

    var view: PresenterToViewSearchBooksProtocol?

    var router: PresenterToRouterSearchBooksProtocol?

    func showBooks(title:String,author:String) {
        
        if let viewController = view?.viewController
        {
            router?.showBooks(for: viewController,title:title,author:author)
        }

    }

    func showLibrary() {
        if let viewController = view?.viewController
        {
            router?.showLibrary(for: viewController)
        }
    }

    func saveLastSearchValue(title:String,author:String) {
        UserDefaults.standard.set(title, forKey: "title")
        UserDefaults.standard.set(author, forKey: "author")
        UserDefaults.standard.synchronize()
    }

    func viewDidLoad() {
        if let title = UserDefaults.standard.string(forKey: "title"),  let author = UserDefaults.standard.string(forKey: "author")
        {
            view?.setLastValues(title: title, author: author)
        }


    }
}
