//
//  NoteTableView.swift
//  SimplyNotes
//
//  Created by Vitalii Kryvoshapka on 09.12.2021.
//

import UIKit
import CoreData

//create list of notes (Public var)
var noteList = [Note]()

class NoteTableView: UITableViewController{

    //LoadData from CD
    var firstLoad = true
    
    override func viewDidLoad() {
        if(firstLoad){
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let note = result as! Note
                    noteList.append(note)
                }
            }
            catch {
                print("Fetch Failed!")
            }
        }
    }
    
    //Configure cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noteCell = tableView.dequeueReusableCell(withIdentifier: "noteCellID", for: indexPath) as! NoteCell
        
        let thisNote: Note!
        thisNote = noteList[indexPath.row]
        
        noteCell.titleLabel.text = thisNote.title
        noteCell.descriptionLabel.text = thisNote.desc
        
        
        return noteCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
}
