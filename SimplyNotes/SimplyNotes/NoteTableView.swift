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
        //insert nonDeleteNotes (instead of noteList)
        thisNote = nonDeleteNotes()[indexPath.row]
        
        noteCell.titleLabel.text = thisNote.title
        noteCell.descriptionLabel.text = thisNote.desc
        
        
        return noteCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //insert nonDeleteNotes (instead of noteList)
        return nonDeleteNotes().count
    }
    
    //Reload Data
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //Add Edit Screen
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
    
    
//    @IBAction func showAccountButton(_ sender: Any) {
//        let AccVC = self.storyboard?.instantiateViewController(withIdentifier: "AccountVC") as! AccountViewController
//        self.present(AccVC, animated: true, completion: nil)
//    }
}





