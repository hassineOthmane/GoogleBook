//
//  ViewController.swift
//  googleBook
//
//  Created by hassine othmane on 7/9/21.
//

import UIKit

class SearchBookView: UIViewController {

    private let ui = SearchBookViewUI()

    override func viewDidLoad() {
        super.viewDidLoad()
        ui.delegate = self
        view = ui
        // Do any additional setup after loading the view.
    }

}

extension SearchBookView: SearchBookUIDelegate {
    func search() {
    }

}
