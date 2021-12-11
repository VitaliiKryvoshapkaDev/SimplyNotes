//
//  ViewController.swift
//  SimplyNotes
//
//  Created by Vitalii Kryvoshapka on 08.12.2021.
//

import UIKit
import CoreData

class NoteDetailVC: UIViewController {

    @IBOutlet weak var titleTF: UITextField!
    
    @IBOutlet weak var descriptionTV: UITextView!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    //For edit selected note
    var selectedNote: Note? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //For edit selected note
        if(selectedNote != nil){
            titleTF.text = selectedNote?.title
            descriptionTV.text = selectedNote?.desc
        }
        
        deleteButton.shake()
    }


    @IBAction func saveAction(_ sender: Any) {
        //Create obj appDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Save edited note
        if(selectedNote == nil)
        {
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        let newNote = Note(entity: entity!, insertInto: context)
        newNote.id = noteList.count as NSNumber
        newNote.title = titleTF.text
        newNote.desc = descriptionTV.text
        do
        {
            try context.save()
            noteList.append(newNote)
            navigationController?.popViewController(animated: true)
        }
        catch{
           print("Context save error")
        }
        }
        
        //Edit
        else{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let note = result as! Note
                    noteList.append(note)
                    if(note == selectedNote){
                        note.title = titleTF.text
                        note.desc = descriptionTV.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            }
            catch {
                print("Fetch Failed!")
            }
        }
    }
    
    //Delete Button
    @IBAction func deleteNote(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
       
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results {
                
                let note = result as! Note
               // noteList.append(note)
                if(note == selectedNote){
                    note.deletedDate = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        }
        catch {
            print("Fetch Failed!")
        }
    }
}

//Add Shake Delete button
public extension UIView {
    
    func shake(count : Float = 5,for duration : TimeInterval = 0.4,withTranslation translation : Float = 5) {
        
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        self.layer.add(animation, forKey: "shake")
    }
}
