//
//  BookModel.swift
//  googleBook
//
//  Created by hassine othmane on 7/10/21.
//

import Foundation

public struct BookModel: Decodable {

    let id: String?

    let volumeInfo : VolumeInfo?

    var isFavorite : Bool?
}


public struct VolumeInfo: Decodable {

    let title: String?

    let description: String?

    let imageLinks : ImageLinks?

    let previewLink : String?

    let authors : [String]?
}


public struct ImageLinks: Decodable {

    let smallThumbnail: String?

}


