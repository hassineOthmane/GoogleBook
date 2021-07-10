//
//  ViewController.swift
//  googleBook
//
//  Created by hassine othmane on 7/9/21.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewSearchBooksProtocol:BaseViewProtocol {

    var presenter: ViewToPresenterSearchBooksProtocol? { get set }

    func setLastValues(title:String,author:String)

}

class SearchBooksView: UIViewController {

    private let ui = SearchBooksViewUI()
    var presenter: ViewToPresenterSearchBooksProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        iniUI()
        initNavigationBar()
        presenter?.viewDidLoad()
    }

    func iniUI() -> Void
    {
        ui.delegate = self
        view = ui
    }

    func initNavigationBar () {
        DispatchQueue.main.async {
            self.title = "Search Book"
            self.navigationController?.navigationBar.tintColor = Colors.backgroundColor
        }
    }

}

extension SearchBooksView: SearchBooksUIDelegate {
    func showLibrary() {
        presenter?.showLibrary()
    }

    func search(title:String,author:String) {
        presenter?.showBooks(title:title,author:author)
        presenter?.saveLastSearchValue(title: title, author: author)
    }

}

extension SearchBooksView: PresenterToViewSearchBooksProtocol {
    func setLastValues(title: String, author: String) {
        ui.setLastValyes(title: title, author: author)
    }


    var viewController: UIViewController {
        return self
    }
}
