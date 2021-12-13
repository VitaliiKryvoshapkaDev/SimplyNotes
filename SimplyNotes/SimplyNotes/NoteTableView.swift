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
    
    //MARK: - OUTLETS -
    @IBOutlet weak var editScreenButton: UIBarButtonItem!
    
    //LoadData from CD
    var firstLoad = true
    
    //Delete from Date
    func nonDeleteNotes() -> [Note]{
        var nonDeleteNoteList = [Note]()
        for note in noteList {
            if(note.deletedDate == nil){
                nonDeleteNoteList.append(note)
            }
        }
        return nonDeleteNoteList
    }
    
    //MARK: - LIFECYCLE -
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
    
    //Reload Data
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //MARK: - CONFIGURE CELL -
    //Configure cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noteCell = tableView.dequeueReusableCell(withIdentifier: "noteCellID", for: indexPath) as! NoteCell
        
        let thisNote: Note!
        //Insert nonDeleteNotes (instead of noteList)
        thisNote = nonDeleteNotes()[indexPath.row]
        
        noteCell.titleLabel.text = thisNote.title
        noteCell.descriptionLabel.text = thisNote.desc
        
        // CORNER RADIUS CELL
        noteCell.contentView.layer.cornerRadius = 3
        //NoteCell.contentView.layer.borderColor = UIColor.darkGray
        noteCell.contentView.layer.borderWidth = 1
        //NoteCell.backgroundColor = .clear
        return noteCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Insert nonDeleteNotes (instead of noteList)
        return nonDeleteNotes().count
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            noteList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
            tableView.reloadData()
        }
    }
    //MARK: - move to edit screen -
    //Add Edit Screen (Navigate to edit screen)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editNote", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "editNote"){
            let indexPath = tableView.indexPathForSelectedRow!
            let noteDetail = segue.destination as? NoteDetailVC
            let selectedNote : Note!
            //Insert nonDeleteNotes (instead of noteList)
            selectedNote = nonDeleteNotes()[indexPath.row]
            noteDetail!.selectedNote = selectedNote
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

