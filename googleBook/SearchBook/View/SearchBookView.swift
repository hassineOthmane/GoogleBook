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
        // Do any additional setup after loading the view.
    }

}

extension SearchBooksView: SearchBooksUIDelegate {
    func search(title:String,author:String) {

        presenter?.showBooks(title:title,author:author)

    }


}

extension SearchBooksView: PresenterToViewSearchBooksProtocol {

    var viewController: UIViewController {
        return self
    }

}
