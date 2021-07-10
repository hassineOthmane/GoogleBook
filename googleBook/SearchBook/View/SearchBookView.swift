//
//  ViewController.swift
//  googleBook
//
//  Created by hassine othmane on 7/9/21.
//

import UIKit

protocol BaseViewProtocol: class {

    var viewController : UIViewController { get }

}

// MARK: View Output (Presenter -> View)
protocol PresenterToViewSearchBooksProtocol:BaseViewProtocol {

    /// configuration
    var presenter: ViewToPresenterSearchBooksProtocol? { get set }

}

class SearchBooksView: UIViewController {

    private let ui = SearchBooksViewUI()
    var presenter: ViewToPresenterSearchBooksProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.delegate = self
        view = ui
        initNavigationBar()
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
    }

}

extension SearchBooksView: PresenterToViewSearchBooksProtocol {

    var viewController: UIViewController {
        return self
    }

}
