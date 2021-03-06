//
//  DataStore.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 07.05.21.
//

public protocol DataStore {
    
    associatedtype T = Storable & MappableProtocol
        
    typealias DeletionCompletion<T> = (Error?) -> Void where T: Storable & MappableProtocol
    typealias CreationCompletion = (Error?) -> Void
    typealias RetrievalCompletion<T> = (RetrieveDataResult<T>) -> Void where T: Storable & MappableProtocol
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func create<T: Storable & MappableProtocol>(_ feed: [T], completion: @escaping CreationCompletion)
    
    //updates or create if not found
    func update<T>(_ item: T, predicate: NSPredicate?, completion: @escaping RetrievalCompletion<T>) where T : Storable & MappableProtocol
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func retrieve<T: Storable & MappableProtocol>(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, completion: @escaping RetrievalCompletion<T>)
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func delete<T: Storable & MappableProtocol>(predicate: NSPredicate?, entity: T.Type, completion: @escaping DeletionCompletion<T>)
    func deleteAll<T: Storable & MappableProtocol>(entity: T.Type, completion: @escaping DeletionCompletion<T>)
}
