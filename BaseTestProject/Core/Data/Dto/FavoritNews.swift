//
//  FavoritNews.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 02/12/20.
//

import Foundation
import CoreData

public class FavoritNews: NSManagedObject {
    @NSManaged public var url: String
    
}

extension FavoritNews {
    static func getAllAccounts() -> NSFetchRequest<FavoritNews> {
        let request: NSFetchRequest<FavoritNews> = NSFetchRequest<FavoritNews>(entityName: "FavoritNews")
        let sortDescription = NSSortDescriptor(key: "url", ascending: true)
        request.sortDescriptors = [sortDescription]
        return request
    }
}
