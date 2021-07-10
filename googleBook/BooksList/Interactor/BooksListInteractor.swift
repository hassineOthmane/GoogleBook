//
//  BooksListInteractor.swift
//  googleBook
//
//  Created by hassine othmane on 7/10/21.
//

import Foundation
import CoreData
import UIKit

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorBooksListProtocol {

    var presenter: InteractorToPresenterBooksListProtocol? { get set }

    func fetchBooks(title:String,author:String)

    func fetchMoreBooks(title:String,author:String,index:Int)

    func saveFavoris(book: BookModel)

    func fetchFavoritesBook() 

}


class BooksListInteractor: PresenterToInteractorBooksListProtocol {


    var presenter: InteractorToPresenterBooksListProtocol?

    func fetchBooks(title: String, author: String) {


        fetchBooks(title: title, author: author) { [self](result: Result<BooksModel, Error>) in
            switch result {
            case .success(let books):
                presenter?.set(books: books)
                break;
            case .failure(let error):
                print(error)
                break;
            }
        }

    }

    func fetchMoreBooks(title: String, author: String, index: Int) {
        fetchMoreBooks(title: title, author: author, index: index) { [self](result: Result<BooksModel, Error>) in
            switch result {
            case .success(let books):
                presenter?.loadMore(books: books)
                break;
            case .failure(let error):
                print(error)
                break;
            }
        }
    }


    func fetchBooks(title:String,author:String,completion: @escaping (Result<BooksModel, Error>) -> Void) {
        let titleQueryItem = URLQueryItem(name: "q", value: title)
        let authorQueryItem = URLQueryItem(name: "inauthor", value: author)
        let networkRequest:NetworkRouter = HTTPRouter.init(method: .get, scheme: "https", host: "www.googleapis.com", path: "/books/v1", endPoint: HTTPEndPoint.getBooks, queries: [titleQueryItem,authorQueryItem])
        let testNetworkLayer = HTTPLayer.init()
        let service = BookNetworkService.init(networkLayer: testNetworkLayer, networkRouter:networkRequest )
        service.fetchBooks(completion: completion)
    }

    func fetchMoreBooks(title:String,author:String,index:Int,completion: @escaping (Result<BooksModel, Error>) -> Void) {
        let titleQueryItem = URLQueryItem(name: "q", value: title)
        let authorQueryItem = URLQueryItem(name: "inauthor", value: author)
        let indexQueryItem = URLQueryItem(name: "startIndex", value: index.description)
        let networkRequest:NetworkRouter = HTTPRouter.init(method: .get, scheme: "https", host: "www.googleapis.com", path: "/books/v1", endPoint: HTTPEndPoint.getBooks, queries: [titleQueryItem,authorQueryItem,indexQueryItem])
        let testNetworkLayer = HTTPLayer.init()
        let service = BookNetworkService.init(networkLayer: testNetworkLayer, networkRouter:networkRequest )
        service.fetchBooks(completion: completion)
    }





    func fetchFavoritesBook() -> Void {
         guard let appDelegate =
           UIApplication.shared.delegate as? AppDelegate else {
             return
         }
         let managedContext = appDelegate.persistentContainer.viewContext
         let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BookDataModel")
         do {
           if let booksList = try managedContext.fetch(fetchRequest) as? [BookDataModel]
           {
            let booksMapped = booksList.map { (book) -> BookModel in return book.toDomain()}
            presenter?.set(books: BooksModel.init(items: booksMapped))
           }

         } catch let error as NSError {
           print("Could not fetch. \(error), \(error.userInfo)")
         }
    }




    func saveFavoris(book: BookModel) {

        if !checkIfUserExist(id: book.id ?? "")
        {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "BookDataModel",
                                       in: managedContext)!
        let bookDataModel = NSManagedObject(entity: entity,insertInto: managedContext)
        bookDataModel.setValue(book.id, forKeyPath: "iD")
        bookDataModel.setValue(book.volumeInfo?.authors?.first ?? "", forKeyPath: "author")
        bookDataModel.setValue(book.volumeInfo?.description, forKeyPath: "link")
        bookDataModel.setValue(book.volumeInfo?.title, forKeyPath: "title")
        bookDataModel.setValue(book.volumeInfo?.imageLinks?.smallThumbnail, forKeyPath: "urlImage")
        bookDataModel.setValue(book.volumeInfo?.description, forKeyPath: "descriptionBook")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
            
        }
    }

    func checkIfUserExist(id:String) -> Bool {
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BookDataModel")
        do {
          if let booksList = try managedContext.fetch(fetchRequest) as? [BookDataModel]
          {
           let booksMapped = booksList.map { (book) -> BookModel in return book.toDomain()}
            return booksMapped.contains { (model) -> Bool in
             return   model.id == id
            }
          }

        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
        return false
    }


}
