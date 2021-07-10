//
//  BooksListViewUI.swift
//  googleBook
//
//  Created by hassine othmane on 7/10/21.
//

import UIKit
import PDFKit

class BooksListViewUI: UIView {

    var isLoading = false

    var page = 1

    var delegate: BooksListViewUIDelegate?

    var dataSource: BooksListViewUIDataSource?

    lazy var tableView : UITableView = {
        let tbl = UITableView()
        tbl.delegate = self
        tbl.dataSource = self
        tbl.separatorColor = .clear
        tbl.backgroundColor = Colors.backgroundColor
        tbl.register(BooksViewCell.self, forCellReuseIdentifier: BooksViewCell.self.description())
        tbl.translatesAutoresizingMaskIntoConstraints = false
        return tbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIElements()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        setupConstraints()
    }

    fileprivate func setupUIElements() {
        DispatchQueue.main.async { [self] in
            backgroundColor = Colors.backgroundColor
            addSubview(tableView)
        }

    }


    fileprivate func setupConstraints() {
        // add constraints to subviews
        var constraints = [NSLayoutConstraint]()


        //MARK: tableview constraints
        constraints += [NSLayoutConstraint.init(item: tableView, attribute: .top, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 15)] // tableView.top = hStackView.bottom + 70
        constraints += [NSLayoutConstraint.init(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0)] // tableView.leading = safeAreaLayoutGuide.leading + 15
        constraints += [NSLayoutConstraint.init(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0)] // tableView.trailing = safeAreaLayoutGuide.trailing - 15
        constraints += [NSLayoutConstraint.init(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0)] // tableView.bottom = safeAreaLayoutGuide.bottom + 20

        DispatchQueue.main.async {
            self.addConstraints(constraints)
        }

    }

    func reloadData() -> Void
    {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}


extension BooksListViewUI: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource?.getBooksCount()  ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: BooksViewCell.self.description(), for: indexPath) as? BooksViewCell else {
                fatalError("Misconfigured cell!")
            }
            if let book = self.dataSource?.getBooks()[indexPath.section]
            {
                cell.delegate = delegate
                cell.set(book: book)
                cell.displayfavorisBtn(self.dataSource?.isOffline() ?? false)
            }

            return cell
    }

}

extension BooksListViewUI: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init()
        view.backgroundColor = .clear
        return view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let book = self.dataSource?.getBooks()[indexPath.section]
        {
            delegate?.showDetail(book: book)
        }

    }

}

extension BooksListViewUI: UIScrollViewDelegate {


    private func createSpinnerView() -> UIView
    {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if (position > (tableView.contentSize.height-scrollView.frame.size.height - 100) ) && isLoading == false &&  self.dataSource?.getBooksCount() ?? 0 > 0
        {
            page += 1
            self.tableView.tableFooterView = createSpinnerView()
            delegate?.fetchMoreBooks(page: page)
            isLoading = true
        }
    }
}
