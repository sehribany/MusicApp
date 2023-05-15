//
//  DataPersistenceManager.swift
//  MusicPlayer
//
//  Created by Şehriban Yıldırım on 13.05.2023.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    // Enums
    enum DatabaseError: Error {
        
        case failedToSaved
        case failedToFetchData
        case failedToDelete
        
    }

    static let shared = DataPersistenceManager()
    
    // Save To CoreData
    
    func downloadTitleWith(model: AlbumDetailData, compleation: @escaping (Result <Void, Error>) -> Void){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context           = appDelegate.persistentContainer.viewContext
        
        let item             = Track(context: context)
        
        item.title    = model.title
        item.preview  = model.preview
        item.duration = Int32(model.duration)
        item.id       = Int64(model.id)
        
        do{
            
            try context.save()
            compleation(.success(()))
            
        }catch{
            
            compleation(.failure(DatabaseError.failedToSaved))
            
        }
    }

    
    // Fetch Data From CoreData
    
    func fetchingTitlesFromDatabase(completion: @escaping ( Result <[Track], Error> ) -> Void){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{ return }
        
        let context           = appDelegate.persistentContainer.viewContext
        
        let request           : NSFetchRequest <Track>
       
        request               = Track.fetchRequest()
        
        do{
            
            let titles = try context.fetch(request)
            completion(.success(titles))
            
        }catch{
            
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    // Delete Data From CoreData
    
    func deleteTitleWith(model: Track, completion: @escaping ( Result <Void, Error> ) -> Void ){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{ return }
        
        let context           = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do{
            
            try context.save()
            completion(.success(()))
            
        }catch{
            
            completion(.failure(DatabaseError.failedToDelete))
        }
    }
}

