//
//  BookDataModel+CoreDataProperties.swift
//  googleBook
//
//  Created by hassine othmane on 7/10/21.
//
//

import Foundation
import CoreData


extension BookDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookDataModel> {
        return NSFetchRequest<BookDataModel>(entityName: "BookDataModel")
    }

    @NSManaged public var iD: String?
    @NSManaged public var author: String?
    @NSManaged public var link: String?
    @NSManaged public var title: String?
    @NSManaged public var urlImage: String?
    @NSManaged public var descriptionBook: String?

}
