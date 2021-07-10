//
//  BookModel.swift
//  googleBook
//
//  Created by hassine othmane on 7/10/21.
//

import Foundation

public struct BookModel: Decodable {

    let kind: String?

    let id: String?

    let volumeInfo : VolumeInfo?
}


public struct VolumeInfo: Decodable {

    let title: String?

    let description: String?

    let imageLinks : ImageLinks?

    let authors : [String]?
}


public struct ImageLinks: Decodable {

    let smallThumbnail: String?

    let thumbnail: String?

}


