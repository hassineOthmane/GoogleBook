//
//  BooksViewCell.swift
//  googleBook
//
//  Created by hassine othmane on 7/10/21.
//

import UIKit

class BooksViewCell : UITableViewCell {

    let cellUI = BookViewCellUI()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        setupUI()
    }

    private func setupUI() {
        cellUI.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cellUI)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        cellUI.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 10).isActive=true
        cellUI.topAnchor.constraint(equalTo: self.topAnchor,constant: 10).isActive=true
        cellUI.rightAnchor.constraint(equalTo: self.rightAnchor,constant: 10).isActive=true
        cellUI.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10).isActive=true
    }

    func set(book:BookModel) -> Void
    {
        if let title = book.volumeInfo?.title
        {
                self.cellUI.setTile(title: title)
        }

        if let author = book.volumeInfo?.authors?.first
        {
                self.cellUI.setAuthor(author: author)
        }

        if let description = book.volumeInfo?.description
        {
                self.cellUI.setDescription(description: description)
        }

        if let url = book.volumeInfo?.imageLinks?.smallThumbnail
        {
                self.cellUI.setImage(url: url)
        }

    }

}


