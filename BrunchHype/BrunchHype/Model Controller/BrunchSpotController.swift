//
//  BrunchSpotController.swift
//  BrunchHype
//
//  Created by Kristin Samuels  on 4/23/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class BrunchSpotController {
    
    // Singleton
    let sharedInstance = BrunchSpotController()
    // Fetched results thing (Source of truth)
    let fetchedResultsController: NSFetchedResultsController<BrunchSpot>

    init() {

        let request: NSFetchRequest<BrunchSpot> = BrunchSpot.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "tier", ascending: true), NSSortDescriptor(key: "name", ascending: true)]

        let reultsController: NSFetchedResultsController<BrunchSpot> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "tier", cacheName: nil)
        
        fetchedResultsController = reultsController
        
        do {
            try fetchedResultsController.performFetch()
            
        } catch {
            print("There was an error performing the fetch \(error.localizedDescription)")
        }
    }
    // Create
    func create(brunchSpotWith name: String) {
        let _ = BrunchSpot(name: name)
        //save
        saveToPersistentStore()
    }
    // Update
    func update(brunchSpot: BrunchSpot, name: String, tier: String, summary: String) {
        brunchSpot.name = name
        brunchSpot.tier = tier
        brunchSpot.summary = summary
        
        saveToPersistentStore()
    }
    // Delete
    
    func remove(brunchSpot: BrunchSpot) {
        CoreDataStack.context.delete(brunchSpot)
    }
    // Save
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error saving Managed Object Context, item not saved \(error.localizedDescription)")
    }
    
}
    
    
} //End of class
