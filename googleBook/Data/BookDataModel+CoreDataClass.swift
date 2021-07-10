//
//  BookDataModel+CoreDataClass.swift
//  googleBook
//
//  Created by hassine othmane on 7/10/21.
//
//

import Foundation
import CoreData

@objc(BookDataModel)
public class BookDataModel: NSManagedObject {

    public func set(book:BookModel)
    {
        self.iD = book.id
        self.author = book.volumeInfo?.authors?.first
        self.link = book.volumeInfo?.previewLink
        self.title = book.volumeInfo?.title
        self.urlImage = book.volumeInfo?.imageLinks?.smallThumbnail
        self.descriptionBook = book.volumeInfo?.description
    }

    func toDomain() -> BookModel
    {
        return BookModel.init( id: self.iD, volumeInfo: VolumeInfo.init(title: self.title, description: self.descriptionBook, imageLinks: ImageLinks.init(smallThumbnail: self.urlImage), previewLink: self.link, authors: [self.author ?? ""]))
    }

}
