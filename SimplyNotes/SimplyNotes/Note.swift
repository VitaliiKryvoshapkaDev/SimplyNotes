//
//  Note.swift
//  SimplyNotes
//
//  Created by Vitalii Kryvoshapka on 09.12.2021.
//

import CoreData

//Configure CD
@objc (Note)
class Note: NSManagedObject{
    @NSManaged var id: NSNumber!
    @NSManaged var title: String!
    @NSManaged var desc: String!
    @NSManaged var deletedDate: Date?
}
