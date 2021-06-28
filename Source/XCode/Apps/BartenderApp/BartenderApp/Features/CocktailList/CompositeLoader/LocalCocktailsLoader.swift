//
//  LocalCocktailsLoader.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 04.06.21.
//

import Foundation
import CocktailsApiService
import GenericStore
import DrinkStore

public final class LocalCocktailsLoader {
    private let store: DrinkStore
    private let currentDate: () -> Date
    
    public init(store: DrinkStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
}

extension LocalCocktailsLoader: CocktailsLoader {
    public func loadDrinksByFirstLetter(_ letter: Character, completion: @escaping (Result<[Drink], Error>) -> Void) {
        //TODO
        load(query: String(letter), completion: completion)
    }
    
    public func loadDrinks(withIds ids: [String], completion: @escaping (Result<[Drink], Error>) -> Void) {
        //TODO
        
        var predArray = [NSPredicate]()
        for item in ids {
            predArray.append(NSPredicate(format: "idDrink == \(item)"))
        }

        let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: predArray)
                        
        loadDrinks(predicate: predicate) { result in
            completion(result)
        }
    }
    
    public func load(query: String, completion: @escaping (CocktailsLoader.Result) -> Void) {
        let predicate = NSPredicate(format: "strDrink CONTAINS[c] '\(query)'")
        loadDrinks(predicate: predicate, completion: completion)
    }
    
    private func loadDrinks(predicate: NSPredicate, completion: @escaping (CocktailsLoader.Result) -> Void) {
        let recipeSortDescriptor: NSSortDescriptor = NSSortDescriptor(
            key: #keyPath(CoreDataDrink.idDrink),
            ascending: true)
        
        store.retrieve(predicate: predicate, sortDescriptors: [recipeSortDescriptor], completion: { (result: RetrieveDataResult<LocalDrink>) in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case .empty:
                completion(.success([]))
            case .found(feed: let feed):
                completion(.success(feed.toModels()))
            }
        })
    }
    
//    public func load(query: String, completion: @escaping (CocktailsLoader.Result) -> Void) {
//
//        //TODO: load cocktails from a database
//
//        print("load cocktails from a database")
//
//        completion(.success([Drink(idDrink: "00001", strDrink: "Margarita", strDrinkThumb: ""),
//                             Drink(idDrink: "00002", strDrink: "Long Island Ice Tea", strDrinkThumb: ""),
//                             Drink(idDrink: "00003", strDrink: "Pina Colada", strDrinkThumb: ""),
//                             Drink(idDrink: "00004", strDrink: "Whiskey Sour", strDrinkThumb: "")]))
//    }
}

extension LocalCocktailsLoader: CocktailsCache {
    public func save(_ drinks: [Drink], completion: @escaping (Result<Void, Error>) -> Void) {
//        try store.deleteAll(entity: LocalRecipe.self, completion: { (error) in
//            guard let error = error else { return }
//            print(error)
//        })
        store.create(drinks.toLocal(), completion: { (error) in
            guard let error = error else {
                completion(.success(()))
                return
            }
            print(error)
            completion(.failure(error))
        })
    }
}

private extension Array where Element == Drink {
    func toLocal() -> [LocalDrink] {
        return map { LocalDrink(idDrink: $0.idDrink, strDrink: $0.strDrink, strDrinkThumb: $0.strDrinkThumb, strImageSource: $0.strImageSource, strInstructions: $0.strInstructions, ingredients: $0.ingredients) }
    }
}

private extension Array where Element == LocalDrink {
    func toModels() -> [Drink] {
        return map { Drink(idDrink: $0.idDrink, strDrink: $0.strDrink, strDrinkThumb: $0.strDrinkThumb, strImageSource: $0.strImageSource, strInstructions: $0.strInstructions, ingredients: $0.ingredients) }
    }
}