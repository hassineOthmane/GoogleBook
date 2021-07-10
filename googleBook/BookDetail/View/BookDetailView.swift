//
//  PDFDetailView.swift
//  googleBook
//
//  Created by hassine othmane on 7/10/21.
//
import UIKit
import PDFKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewBookDetailProtocol {

    var presenter: ViewToPresenterBookDetailProtocol? { get set }
}

class BookDetailView: UIViewController {

    var presenter: ViewToPresenterBookDetailProtocol?
    private let ui = BookDetailViewUI()

    override func viewDidLoad() {
        super.viewDidLoad()
        ui.dataSource = self
        ui.delegate = self
        view = ui
        initNavigationBar()
    }

    func initNavigationBar () {
        DispatchQueue.main.async {
            self.title = "Book Detail"
            self.navigationController?.navigationBar.tintColor = Colors.backgroundColor
        }
    }
    
}

extension BookDetailView : BookDetailViewUIDataSource
{
    func getBook() -> BookModel? {
        return presenter?.getBook()
    }

}

extension BookDetailView : BookDetailViewUIDelegate
{
    func showUrlPage(url: String) {
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
    }
}
